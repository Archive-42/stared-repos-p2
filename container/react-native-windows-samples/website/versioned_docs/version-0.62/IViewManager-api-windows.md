---
id: version-0.62-iviewmanager-api
title: IViewManager
original_id: iviewmanager-api
---

See the documentation of [Native UI Components](view-managers.md) for information on how to author a ViewManager.

>**This documentation and the underlying platform code is a work in progress.**

# Reference

## Methods


<!-- // Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import "IReactModuleBuilder.idl";
import "IReactContext.idl";

#include "NamespaceRedirect.h"

namespace Microsoft.ReactNative
{
  [webhosthidden]
  enum ViewManagerPropertyType
  {
    Boolean,
    Number,
    String,
    Array,
    Map,
    Color,
  };

  [webhosthidden]
  interface IViewManager
  {
    String Name { get; };

    XAML_NAMESPACE.FrameworkElement CreateView();
  }

  [webhosthidden]
  interface IViewManagerWithReactContext
  {
    IReactContext ReactContext { get; set; };
  }

  [webhosthidden]
  interface IViewManagerWithExportedViewConstants
  {
    ConstantProviderDelegate ExportedViewConstants { get; };
  }

  [webhosthidden]
  interface IViewManagerWithNativeProperties
  {
    IMapView<String, ViewManagerPropertyType> NativeProps { get; };

    void UpdateProperties(XAML_NAMESPACE.FrameworkElement view, IJSValueReader propertyMapReader);
  }

  [webhosthidden]
  interface IViewManagerWithCommands
  {
    IVectorView<String> Commands { get; };

    void DispatchCommand(XAML_NAMESPACE.FrameworkElement view, String commandId, IJSValueReader commandArgsReader);
  }

  [webhosthidden]
  interface IViewManagerWithExportedEventTypeConstants
  {
    ConstantProviderDelegate ExportedCustomBubblingEventTypeConstants { get; };

    ConstantProviderDelegate ExportedCustomDirectEventTypeConstants { get; };
  }

  [webhosthidden]
  interface IViewManagerWithChildren
  {
    void AddView(XAML_NAMESPACE.FrameworkElement parent, XAML_NAMESPACE.UIElement child, Int64 index);

    void RemoveAllChildren(XAML_NAMESPACE.FrameworkElement parent);

    void RemoveChildAt(XAML_NAMESPACE.FrameworkElement parent, Int64 index);

    void ReplaceChild(XAML_NAMESPACE.FrameworkElement parent, XAML_NAMESPACE.UIElement oldChild, XAML_NAMESPACE.UIElement newChild);
  }
} // namespace Microsoft.ReactNative -->
