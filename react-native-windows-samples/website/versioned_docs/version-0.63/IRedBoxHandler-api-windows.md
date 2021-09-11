---
id: version-0.63-iredboxhandler-api
title: IRedBoxHandler
original_id: iredboxhandler-api
---

RedBoxHandler provides an extension point to allow custom error handling within the react instance.  This can be useful if you have an existing error reporting system that you want react errors to be reported to.  The default implementation of RedBoxHandler shows error messages in a full screen error screen within the application.

-- Insert Screenshot here --

If you want to maintain the existing RedBox behaviors, and also report errors to your own reporting system, your implementation can call into the default RedBoxHandler, which can be obtained by calling 

```csharp
RedBoxHelper::CreateDefaultHandler(Host);
```

Sample settings up a RedBoxHandler that reports errors to an external system, and displays the default RedBox experience within the application:

```csharp

class MyRedBoxHandler : IRedBoxHandler
{
  MyRedBoxHandler(IRedBoxHandler defaultHandler)
  {
    innerHandler = defaultHandler;
  }

  public void ShowNewError(IRedBoxErrorInfo info, RedBoxErrorType type) 
  {
    // Dont report non-fatal errors (optional)
    if (type != RedBoxErrorType.JavaScriptSoft) 
      ReportErrorToMyErrorReportingSystem(info, type);

    // Display errors in app if the instance is running with DevSupportEnabled
    if (innerHandler.IsDevSupportEnabled)
      innerHandler.ShowNewError(info, type);
  }

  public bool IsDevSupportEnabled { get; }
  {
    // The default handler will return true if the instance has DevSupport turned on
    // But if you want to record error information in released versions of your app
    // Then you should return true here, so that all errors get reported.
    return true;
  }

  public void UpdateError(IRedBoxErrorInfo info)
  {
    if (innerHandler.IsDevSupportEnabled)
      innerHandler.UpdateError(info);
  }

  public void DismissRedBox()
  {
    if (innerHandler.IsDevSupportEnabled)
      innerHandler.DismissRedBox();
  }

  private IRedBoxHandler innerHandler;
}


RegisterMyRedBoxHandler()
{
  Host.InstanceSettings.RedBoxHandler = new MyRedBoxHandler(RedBoxHelper.CreateDefaultHandler(Host));
}

```


# Reference

# IRedBoxHandler

## Methods

### `ShowNewError()`

```csharp
void ShowNewError(IRedBoxErrorInfo info, RedBoxErrorType type)
```

This method is called when an error is initially hit.

### `UpdateError()`

```csharp
void UpdateError(IRedBoxErrorInfo info)
```

This method is called when updated information about an error has been resolved.  For javascript errors, this is called if source map information was able to be resolved to provide a more useful call stack.

## Properties

### `IsDevSupportEnabled`

```csharp
  bool IsDevSupportEnabled { get; };
```

This property will control if errors should be reported to the handler.  If this returns false, [ShowNewError](#shownewerror) and [UpdateError](#updateerror) will not be called.

# RedBoxErrorType (enum)

| RedBoxErrorType       | Description     |
| :------------- | :----------- |
| JavaScriptFatal | A JS Exception was thrown and not caught or otherwise fatal error   |
| JavaScriptSoft   | An error coming from JS that isn't fatal, such as console.error |
| Native   | An error happened in native code |

# IRedBoxErrorFrameInfo

This object represents a single frame within the call stack of an error.

## Properties

### `File`

```csharp
string File { get; };
```

The file location of this frame


### `Method`

```csharp
string Method { get; };
```

The method name of this frame


### `Line`

```csharp
uint Line { get; };
```

The line number within the file


### `Column`

```csharp
uint Column { get; };
```

The column within the line


### `Collapse`

```csharp
bool Collapse { get; };
```

Tru if this frame is part of the internals of react-native, that is likely not useful for the developer to see.


# IRedBoxErrorInfo

This object provides information about the error.  For javascript errors, a call stack is also provided.

## Properties

### `Message`

```csharp
string Message { get; };
```

The error message.


### `Id`

```csharp
uint Id { get; };
```

This Id can be used in [UpdateError](#updateerror) to identify which error is being updated.  For native errors, this is currently always `0`, and [UpdateError](#updateerror) will never be called.


### `Callstack`

```csharp
IVector<IRedBoxErrorFrameInfo> Callstack { get; };
```

For JavaScript errors, this will contain the call stack of where the error occurred.


### `OriginalMessage`

```csharp
string OriginalMessage { get; };
```

If the message was adjusted for formatting, or otherwise processed, this contains the message before those modifications


### `Name`

```csharp
string Name { get; };
```

An identifier for this error.


### `ComponentStack`

```csharp
string ComponentStack { get; };
```

This will contain the component stack where the error occurred, which can help identify the component that is producing the error


### `ExtraData `

```csharp
IJSValueReader ExtraData  { get; };
```

Provides access to extra data attached to the error.  Adding additional data to the errors is not yet part of the stable API.


# RedBoxHelper

## Methods

### `CreateDefaultHandler`

```csharp
static IRedBoxHandler CreateDefaultHandler(ReactNativeHost host);
```

This provides access to the default `IRedBoxHandler`. This can be used to display the default RedBox as part of a custom RedBoxHandler implementation.

<!--

import "ReactNativeHost.idl";

namespace Microsoft.ReactNative {

  enum RedBoxErrorType {
    JavaScriptFatal, // A JS Exception was thrown and not catched or otherwise fatal error
    JavaScriptSoft, // An error coming from JS that isn't fatal, such as console.error
    Native,
  };

  [webhosthidden] interface IRedBoxErrorFrameInfo {
    String File { get; };
    String Method { get; };
    UInt32 Line { get; };
    UInt32 Column { get; };
  }

  [webhosthidden] interface IRedBoxErrorInfo {
    String Message { get; };
    UInt32 Id { get; };
    IVectorView<IRedBoxErrorFrameInfo> Callstack { get; };
  }

  [webhosthidden]
  interface IRedBoxHandler 
  {
    void ShowNewError(IRedBoxErrorInfo info, RedBoxErrorType type);
    Boolean IsDevSupportEnabled { get; };
    void UpdateError(IRedBoxErrorInfo info);
    void DismissRedBox();
  }

  [webhosthidden]
  [default_interface]
  runtimeclass RedBoxHelper {
    RedBoxHelper();
    static IRedBoxHandler CreateDefaultHandler(Microsoft.ReactNative.ReactNativeHost host);
  }

}
-->