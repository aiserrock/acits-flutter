[English](../../CONTRIBUTING.md) · **简体中文** · [हिन्दी](../hi/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Русский](../ru/CONTRIBUTING.md)

# 为 acits_flutter 做贡献

感谢你对 **acits_flutter** 项目的贡献兴趣——这是 [acits.ru](https://acits.ru) 的 Flutter 移动客户端，一款用于动物收容所内动物追踪的自由开源软件。

本项目采用 **MIT 许可证**。参与贡献即表示你同意你的贡献将以相同条款授权。

代码仓库：[github.com/aiserrock/acits-flutter](https://github.com/aiserrock/acits-flutter)

---

## 目录

- [环境准备](#prerequisites)
- [项目搭建](#project-setup)
- [分支模型](#branching-model)
- [提交信息](#commit-messages)
- [编码规范](#coding-standards)
- [本地化](#localisation)
- [测试](#testing)
- [提交 PR 前的检查清单](#pre-pr-checklist)
- [发起 Pull Request](#opening-a-pull-request)
- [报告 Bug](#reporting-bugs)

---

## 环境准备

工具链版本通过仓库根目录的 `.fvmrc` 文件由 **FVM**（Flutter Version Management）锁定。

| 工具 | 版本 |
| --- | --- |
| Flutter | 3.44.0 |
| Dart | 3.12.0 |
| FVM | 最新稳定版 |

安装 FVM 及锁定的 SDK：

```bash
dart pub global activate fvm
fvm install
```

执行 Flutter 和 Dart 命令时始终加上 `fvm` 前缀，以确保使用锁定的 SDK：

```bash
fvm flutter <command>
fvm dart <command>
```

构建和运行本应用还需要一套可用的 Android 和/或 iOS 工具链（Android Studio / Xcode）。

---

## 项目搭建

1. 在 GitHub 上 **Fork** 本仓库，并 **克隆** 你的 Fork：

   ```bash
   git clone git@github.com:<your-username>/acits-flutter.git
   cd acits-flutter
   ```

2. **添加 upstream 远程仓库**，以便与你的 Fork 保持同步：

   ```bash
   git remote add upstream git@github.com:aiserrock/acits-flutter.git
   ```

3. **拉取依赖：**

   ```bash
   fvm flutter pub get
   ```

4. **复制示例配置模板。** Firebase 配置文件已被 gitignore 排除；请复制 `*.example` 模板并填入你自己的凭据：

   ```bash
   # Android —— 按 flavour 区分，每个 flavour 一个文件：
   cp android/app/src/dev/google-services.json.example android/app/src/dev/google-services.json
   cp android/app/src/prod/google-services.json.example android/app/src/prod/google-services.json
   # iOS
   cp ios/Runner/GoogleService-Info.plist.example ios/Runner/GoogleService-Info.plist
   ```

   > 如果你需要在本地配置签名，`android/keystore/` 下的 `key.properties.example` 遵循相同的模式。

5. **生成代码。** 本项目使用代码生成来处理 DI（injectable）、JSON 序列化和 Chopper：

   ```bash
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

6. **运行应用。** 项目有两个 flavour，各自拥有独立的入口文件：

   ```bash
   # dev flavour
   fvm flutter run -t test/dev/main.dart --flavor dev

   # prod flavour
   fvm flutter run -t lib/main.dart --flavor prod
   ```

---

## 分支模型

我们采用 **git-flow** 风格的分支模型：

| 分支 | 用途 |
| --- | --- |
| `main` | 稳定的、可发布的代码。始终保持可部署状态。切勿直接向其提交 PR。 |
| `develop` | 功能开发的集成分支。所有贡献都应以此分支为目标。 |
| `feature/*` | 从 `develop` 分出的具体功能和修复分支。 |

从 `develop` 创建你的分支：

```bash
git fetch upstream
git checkout develop
git merge upstream/develop
git checkout -b feature/short-descriptive-name
```

Pull Request 始终 **面向 `develop` 提交**，绝不面向 `main`。

---

## 提交信息

我们使用 [**Conventional Commits**](https://www.conventionalcommits.org/) 规范。每条提交信息的格式为：

```
<type>(<optional scope>): <description>
```

常用类型：

| 类型 | 含义 |
| --- | --- |
| `feat` | 新功能。 |
| `fix` | Bug 修复。 |
| `refactor` | 既不修复 Bug 也不添加功能的代码改动。 |
| `docs` | 仅文档改动。 |
| `test` | 添加或修正测试。 |
| `chore` | 构建流程、工具链或依赖变更。 |
| `style` | 不影响代码逻辑的格式化改动。 |

示例：

```text
feat(animals): add photo gallery to animal detail screen
fix(auth): handle expired token on cold start
docs: update contributing guide for FVM 3.44
```

---

## 编码规范

- **每行长度限制为 100**（而非 Dart 默认的 80）。格式化所有改动：

  ```bash
  fvm dart format -l 100 lib test
  ```

- **状态管理使用 `flutter_bloc` 的 Cubit**，配合密封类 `DataState<T>`（`lib/util/data_state.dart`），并通过 `DataStateBuilder` 渲染。Cubit 通过 `safeEmit`（`lib/util/bloc_ext.dart`）发出状态，以避免在 close 之后继续 emit。表单输入使用 `formz`；模型使用 `equatable`。

- **事件和状态均为密封类（sealed classes）。** 在需要完整 BLoC 的场景中，将其事件和状态定义为附属于该 bloc 文件的密封类。对于简单的请求/响应类页面，优先使用配合 `DataState<T>` 的 Cubit。

- **导航使用 `go_router`**（`lib/navigation/app_router.dart`）。路由以常量形式声明在 `AppRoutes` 中；复杂对象通过 `extra` 传递，并通过 `AppExtraCodec` 编解码。不要使用命令式的 `Navigator` 调用或具名路由。

- **依赖注入使用 `get_it` + `injectable` 3。** `initDi()` 在 `main` 中于 `runApp` 之前被调用。修改任何 `@injectable` 注解后需重新运行 `build_runner`。**不要在 DI 中注册 Cubit/BLoC**——应在页面 Widget 中通过 `BlocProvider` 提供它们，并在构造函数中从 `getIt` 获取其依赖。

- **网络请求使用 Chopper + Dio**，代码由 `doc/api/` 下的 OpenAPI 规范生成至 `lib/api/`。切勿手动编辑生成文件（`*.g.dart`、`*.chopper.dart`、`*.swagger.dart`）。手写 DTO 时使用 `@JsonSerializable` 并配合 `part '<name>.g.dart';`。

- **存储** 统一通过 `lib/service/` 中对 `flutter_secure_storage` 和 `shared_preferences` 的封装进行。不要在功能代码中直接调用 `SharedPreferences.getInstance()`。

- **优先使用 `package:` 形式的导入**（`package:acits_flutter/...`），而非相对路径导入。每个页面文件夹都提供一个 `<feature>.dart` barrel 文件；项目级的 `export.dart` barrel 统一重导出公共部分。

- **文档注释使用俄语撰写**，以匹配现有代码库风格。

### 项目结构

```text
lib/
├── api/           # Chopper/OpenAPI 生成的 HTTP 层（请勿编辑）
├── di/            # get_it + injectable 容器
├── domain/        # 纯 Dart 领域模型
├── generated/     # 生成的 LocaleKeys（请勿编辑）
├── navigation/    # go_router 配置（app_router.dart、AppRoutes）
├── res/           # 设计令牌（颜色、样式、图标）
├── service/       # 按职责分组的可注入服务
├── ui/
│   ├── screen/<feature>/   # 每个页面的 bloc-or-cubit / view / model
│   └── widget/             # 全应用共享的 widget
├── util/          # 辅助函数、DataState、bloc_ext
└── export.dart    # 项目级 barrel 文件
```

---

## 本地化

本地化使用 **easy_localization**。翻译文件位于 `assets/translations/en.json` 和 `assets/translations/ru.json`，键值生成到 `LocaleKeys`（`lib/generated/locale_keys.g.dart`）。英语和俄语翻译均已完整，回退语言为 `ru`。

UI 中 **不允许存在硬编码的用户可见字符串**。

添加一个字符串的步骤：

1. 在 `assets/translations/en.json` **和** `assets/translations/ru.json` 中添加 **相同的键**。
2. 重新生成键值：

   ```bash
   fvm dart run easy_localization:generate \
     -S assets/translations -O lib/generated -o locale_keys.g.dart -f keys
   ```

3. 在代码中使用：

   ```dart
   Text(LocaleKeys.someKey.tr())
   ```

---

## 测试

- **单元测试和 BLoC/Cubit 测试** 位于 `test/unit/`，使用 `mocktail` + `bloc_test`：

  ```bash
  fvm flutter test
  ```

  运行单个文件或按名称匹配：

  ```bash
  fvm flutter test test/unit/path/to/foo_test.dart
  fvm flutter test --name "description substring"
  ```

- **端到端测试** 使用 **Patrol**（`integration_test/`，配置在 `pubspec.yaml` 的 `patrol:` 区块中）：

  ```bash
  patrol test --flavor dev
  ```

新功能应附带测试。Bug 修复在条件允许的情况下应包含回归测试。

---

## 提交 PR 前的检查清单

在发起 Pull Request 之前，请确认以下每一项：

- [ ] 代码已格式化：`fvm dart format -l 100 lib test`。
- [ ] 静态分析无问题：`fvm flutter analyze`。
- [ ] 所有测试通过：`fvm flutter test`。
- [ ] 如果修改了任何 `@injectable` / `@JsonSerializable` / Chopper 注解，已重新生成代码：`fvm dart run build_runner build --delete-conflicting-outputs`。
- [ ] 新增的本地化键已同时添加到 `en.json` 和 `ru.json`，且 `LocaleKeys` 已重新生成。
- [ ] UI 中不再存在任何硬编码的用户可见字符串。
- [ ] 提交信息遵循 Conventional Commits 规范。
- [ ] 分支基于 `develop` 创建。

请提交所有重新生成的文件——已提交到仓库中的生成文件是分析器的唯一可信来源。

---

## 发起 Pull Request

1. 将你的功能分支推送到你的 Fork：

   ```bash
   git push -u origin feature/short-descriptive-name
   ```

2. 在 upstream 仓库中发起一个 **面向 `develop`** 的 Pull Request。

3. 填写 PR 描述：改动内容、原因以及测试方式。**关联相关 issue**（例如 `Closes #123`），以便在合并时被追踪并自动关闭。

4. 确保 **CI 通过**。`.github/workflows/ci.yml` 中的工作流会运行 analyse + test、构建 Android dev APK，以及构建未签名的 iOS 包。

5. 通过向同一分支推送新提交来回应评审意见。

保持 PR 聚焦且规模适中——较小的 PR 能更快获得评审和合并。

---

## 报告 Bug

请使用提供的 **issue 模板** 在 GitHub 上创建 issue。一份好的 Bug 报告应包含：

- 清晰、具描述性的标题。
- 复现步骤。
- 预期行为与实际行为的对比。
- flavour（`dev` / `prod`）、设备型号和操作系统版本。
- 相关的日志、截图或屏幕录制。

请先搜索现有 issue，避免重复提交。涉及安全的报告请私下联系维护者，而非公开提交 issue。

---

感谢你为改善 acits_flutter 以及支持动物收容所所做的贡献。
