#!/usr/bin/env ruby
# Adds the `RunnerUITests` target Patrol needs on iOS, mirroring what
# `patrol bootstrap` does on a fresh project. Idempotent: re-running it is a
# no-op once the target exists.
#
# Hand-editing project.pbxproj is error-prone, so the target is generated with
# the `xcodeproj` gem instead. Kept in the repo because the file is checked in —
# whoever regenerates the Xcode project can re-run this.
#
#   cd ios && ruby add_patrol_uitests_target.rb && pod install
#
# The target deliberately carries NO base configuration reference: CocoaPods
# needs that slot free to attach Pods-Runner-RunnerUITests.*.xcconfig, which is
# what lets the bundle `@import patrol`. Runner's own flavor xcconfigs are not
# inherited, so the bundle identifier is written out per configuration instead
# of via $(identifier)$(bundle_suffix).

require 'xcodeproj'

PROJECT = File.join(__dir__, 'Runner.xcodeproj')
TARGET_NAME = 'RunnerUITests'
APP_ID = 'ru.acits'
TEAM = '45G32KJDV7'

project = Xcodeproj::Project.open(PROJECT)
runner = project.targets.find { |t| t.name == 'Runner' } or abort 'Runner target not found'

if project.targets.any? { |t| t.name == TARGET_NAME }
  puts "#{TARGET_NAME} already exists — nothing to do."
  exit 0
end

target = project.new_target(:ui_test_bundle, TARGET_NAME, :ios, '15.0')

group = project.main_group.find_subpath(TARGET_NAME, true)
group.set_source_tree('SOURCE_ROOT')
group.set_path(TARGET_NAME)
target.add_file_references([group.new_reference('RunnerUITests.m')])

# The bundle must build under every flavor configuration; `patrol test --flavor
# dev` selects Debug-dev, which a default target does not have.
runner_configs = runner.build_configurations.map(&:name)
template_settings = target.build_configurations.first.build_settings.dup

runner_configs.each do |name|
  next if target.build_configurations.any? { |c| c.name == name }

  added = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
  added.name = name
  added.build_settings = template_settings.dup
  target.build_configuration_list.build_configurations << added
end
target.build_configuration_list.build_configurations.delete_if { |c| !runner_configs.include?(c.name) }

target.build_configurations.each do |config|
  # `-dev` configurations map to the dev app (ru.acits.dev); everything else to
  # prod. The suffix mirrors Flutter/{dev,prod}.xcconfig.
  suffix = config.name.end_with?('-dev') ? '.dev' : ''

  config.build_settings.merge!(
    'PRODUCT_BUNDLE_IDENTIFIER' => "#{APP_ID}#{suffix}.#{TARGET_NAME}",
    'PRODUCT_NAME' => '$(TARGET_NAME)',
    'TEST_TARGET_NAME' => 'Runner',
    'DEVELOPMENT_TEAM' => TEAM,
    'CODE_SIGN_STYLE' => 'Automatic',
    'IPHONEOS_DEPLOYMENT_TARGET' => '15.0',
    'SWIFT_VERSION' => '5.0',
  )
  # Owned by Pods-Runner-RunnerUITests.xcconfig — overriding it here makes
  # CocoaPods warn and can break the pod linkage.
  config.build_settings.delete('ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES')
end

target.add_dependency(runner)
project.save

# `xcodebuild test` (what patrol_cli drives) only sees bundles listed as
# testables in the scheme. patrol targets the dev flavor (ru.acits.dev), so the
# dev scheme is the one that needs the entry.
scheme_path = File.join(PROJECT, 'xcshareddata', 'xcschemes', 'dev.xcscheme')
if File.exist?(scheme_path)
  scheme = Xcodeproj::XCScheme.new(scheme_path)
  already_listed = scheme.test_action.testables.any? do |t|
    t.buildable_references.any? { |r| r.target_name == TARGET_NAME }
  end
  unless already_listed
    scheme.test_action.add_testable(Xcodeproj::XCScheme::TestAction::TestableReference.new(target))
    scheme.save!
    puts 'Registered the bundle as a testable in the dev scheme.'
  end
end

puts "Added #{TARGET_NAME} (#{target.build_configurations.map(&:name).join(', ')})."
puts 'Next: pod install'
