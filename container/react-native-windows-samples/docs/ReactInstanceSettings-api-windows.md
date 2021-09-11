---
id: ReactInstanceSettings
title: ReactInstanceSettings
---

Kind: `class`



Provides settings to create a React instance.

## Properties
### BundleRootPath
 string `BundleRootPath`

**Default value**: `ms-appx:///Bundle/`

Base path used for the location of the bundle.

### ByteCodeFileUri
 string `ByteCodeFileUri`

Set this to a location the application has write access to in order for bytecode to be successfully cached. See [`EnableByteCodeCaching`](#enablebytecodecaching).
**Note that currently the byte code generation is not implemented for UWP applications.**

### DebugBundlePath
 string `DebugBundlePath`

When loading from a bundle server (such as metro), this is the path that will be requested from the server. If this is not provided the value of [`JavaScriptBundleFile`](#javascriptbundlefile) or [`JavaScriptMainModuleName`](#javascriptmainmodulename) is used.

### DebugHost
 string `DebugHost`

> **Deprecated**: This has been replaced with [`SourceBundleHost`](#sourcebundlehost) and [`SourceBundlePort`](#sourcebundleport) and will be removed in version 0.65.

**Default value**: `localhost:8081`

When using a [`UseFastRefresh`](#usefastrefresh), [`UseLiveReload`](#uselivereload) or [`UseWebDebugger`](#usewebdebugger) this is the server that will be used to load the bundle from.

### DebuggerBreakOnNextLine
 bool `DebuggerBreakOnNextLine`

For direct debugging, controls whether to break on the next line of JavaScript that is executed.
This can help debug issues hit early in the JavaScript bundle load.
***Note: this is not supported with the Chakra JS engine which is the currently used JavaScript engine. As a workaround you could add the `debugger` keyword in the beginning of the bundle.***

### DebuggerPort
 uint16_t `DebuggerPort`

**Default value**: `9229`

When [`UseDirectDebugger`](#usedirectdebugger) is enabled, this controls the port that the JavaScript engine debugger will run on.

### EnableByteCodeCaching
 bool `EnableByteCodeCaching`

**Default value**: `false`

For JS engines that support bytecode generation, this controls if bytecode should be generated when a JavaScript bundle is first loaded.
Subsequent runs of the application should be faster as the JavaScript will be loaded from bytecode instead of the raw JavaScript.
[`ByteCodeFileUri`](#bytecodefileuri) must be set to a location the application has write access to in order for the bytecode to be successfully cached.
**Note that currently the byte code generation is not implemented for UWP applications.**

### EnableDeveloperMenu
 bool `EnableDeveloperMenu`

> **Deprecated**: This property has been replaced by [`UseDeveloperSupport`](#usedevelopersupport). In version 0.63 both properties will do the same thing. It will be removed in version 0.65.

This controls whether various developer experience features are available for this instance. In particular the developer menu, and the default `RedBox` experience.

### EnableJITCompilation
 bool `EnableJITCompilation`

**Default value**: `true`

Flag controlling whether the JavaScript engine uses JIT compilation.

### JSIEngineOverride
 [`JSIEngine`](JSIEngine) `JSIEngineOverride`

**Default value**: `JSIEngine.Chakra`

The [`JSIEngine`](JSIEngine) override to be used with the React instance.
In order the override to work the Microsoft.ReactNative must be compiled with support of that engine.

### JavaScriptBundleFile
 string `JavaScriptBundleFile`

**Default value**: `index.windows`

The name of the JavaScript bundle file to load. This should be a relative path from [`BundleRootPath`](#bundlerootpath). The `.bundle` extension will be appended to the end, when looking for the bundle file.

### JavaScriptMainModuleName
 string `JavaScriptMainModuleName`

> **Deprecated**: Use [`JavaScriptBundleFile`](#javascriptbundlefile) instead. It will be removed in version 0.65.

Name of the JavaScript bundle file. If [`JavaScriptBundleFile`](#javascriptbundlefile) is specified it is used instead.

### Notifications
`readonly`  [`IReactNotificationService`](IReactNotificationService) `Notifications`

Gets a [`IReactNotificationService`](IReactNotificationService) to send notifications between components and the application.
Use [`IReactContext.Notifications`](IReactContext#notifications) to access this [`IReactNotificationService`](IReactNotificationService) from native components or view managers.

### PackageProviders
`readonly`  [`IVector`](https://docs.microsoft.com/uwp/api/Windows.Foundation.Collections.IVector-1)<[`IReactPackageProvider`](IReactPackageProvider)> `PackageProviders`

Gets a list of [`IReactPackageProvider`](IReactPackageProvider).
Add an implementation of [`IReactPackageProvider`](IReactPackageProvider) to this list to define additional native modules and custom view managers to be included in the React instance.
Auto-linking automatically adds [`IReactPackageProvider`](IReactPackageProvider) to the application's [`PackageProviders`](#packageproviders).

### Properties
`readonly`  [`IReactPropertyBag`](IReactPropertyBag) `Properties`

Gets a [`IReactPropertyBag`](IReactPropertyBag) to share values between components and the application.
Use [`IReactContext.Properties`](IReactContext#properties-1) to access this [`IReactPropertyBag`](IReactPropertyBag) from native components and view managers.

### RedBoxHandler
 [`IRedBoxHandler`](IRedBoxHandler) `RedBoxHandler`

Provides an extension point to allow custom error handling within the react instance. See [`IRedBoxHandler`](IRedBoxHandler) for more information.

### SourceBundleHost
 string `SourceBundleHost`

**Default value**: `localhost`

When using a [`UseFastRefresh`](#usefastrefresh), [`UseLiveReload`](#uselivereload), or [`UseWebDebugger`](#usewebdebugger) this is the server hostname that will be used to load the bundle from.

### SourceBundlePort
 uint16_t `SourceBundlePort`

**Default value**: `8081`

When using a [`UseFastRefresh`](#usefastrefresh), [`UseLiveReload`](#uselivereload), or [`UseWebDebugger`](#usewebdebugger) this is the server port that will be used to load the bundle from.

### UIDispatcher
 [`IReactDispatcher`](IReactDispatcher) `UIDispatcher`

Control the main UI dispatcher to be used by the React instance. If the [`ReactInstanceSettings`](ReactInstanceSettings) object is initially created on a UI thread, then this will default to that thread. The value provided here will be available to native modules and view managers using [`IReactContext.UIDispatcher`](IReactContext#uidispatcher)

### UseDeveloperSupport
 bool `UseDeveloperSupport`

This controls whether various developer experience features are available for this instance. In particular, it enables the developer menu, the default `RedBox` and `LogBox` experience.

### UseDirectDebugger
 bool `UseDirectDebugger`

Enables debugging in the JavaScript engine (if supported).
For Chakra this enables debugging of the JS runtime directly within the app using Visual Studio -> Attach to process (Script)

### UseFastRefresh
 bool `UseFastRefresh`

Controls whether the instance triggers the hot module reload logic when it first loads the instance.
Most edits should be visible within a second or two without the instance having to reload.
Non-compatible changes still cause full reloads.
See [Fast Refresh](https://reactnative.dev/docs/fast-refresh) for more information on Fast Refresh.

### UseLiveReload
 bool `UseLiveReload`

> **Deprecated**: For general use this has been replaced by [`UseFastRefresh`](#usefastrefresh).

Enables live reload to load the source bundle from the React Native packager.
When the file is saved, the packager will trigger reloading.


### UseWebDebugger
 bool `UseWebDebugger`

Controls whether the instance JavaScript runs in a remote environment such as within a browser.
By default, this is using a browser navigated to http://localhost:8081/debugger-ui served by Metro/Haul.
Debugging will start as soon as the react native instance is loaded.


## Constructors
### ReactInstanceSettings
 **`ReactInstanceSettings`**()





## Events
### `InstanceCreated`
Type: [`InstanceCreatedEventArgs`](InstanceCreatedEventArgs)
### `InstanceDestroyed`
Type: [`InstanceDestroyedEventArgs`](InstanceDestroyedEventArgs)
### `InstanceLoaded`
Type: [`InstanceLoadedEventArgs`](InstanceLoadedEventArgs)


## Referenced by
- [`QuirkSettings`](QuirkSettings)
- [`ReactApplication`](ReactApplication)
- [`ReactNativeHost`](ReactNativeHost)
