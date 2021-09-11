---
id: version-0.62-ireactnotificationservice-api
title: IReactNotificationService
original_id: ireactnotificationservice-api
---

*Describe the API*

# Reference

## Methods


<!-- // Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import "IReactDispatcher.idl";
import "IReactPropertyBag.idl";

namespace Microsoft.ReactNative {

  // A subscription to a notification.
  // The subscription is removed when this object is deleted or the Unsubscribe method is called.
  [webhosthidden]
  interface IReactNotificationSubscription
  {
    // Name of the notification.
    IReactPropertyName NotificationName { get; };

    // The IReactDispatcher provided when the notification subscription created.
    // All notifications will be handled using this dispatcher.
    IReactDispatcher Dispatcher { get; };

    // True if the subscription is still active.
    // This property is checked before notification handler is invoked.
    Boolean IsSubscribed { get; };

    // Remove the subscription.
    // Because of the multi-threaded nature of the notifications, the handler can be still called
    // after the Unsubscribe method called if the IsSubscribed property is already checked.
    // Consider calling the Unsubscribe method and the handler in the same IReactDispatcher
    // to ensure that no handler is invoked after the Unsubscribe method call.
    void Unsubscribe();
  }

  // Notification args provided to the notification handler.
  [webhosthidden]
  interface IReactNotificationArgs
  {
    // The notification subscription that can be used to unsubscribe in the notification handler.
    // It also has the name and dispatcher associated with the notification.
    IReactNotificationSubscription Subscription { get; };

    // The data sent with the notification. It can be any WinRT type.
    // Consider using IReactPropertyBag for semi-structured data.
    // It can be null if notification has no data.
    Object Data { get; };
  }

  // Delegate to handle notifications.
  // The sender parameter is the object that sent the notification. It can be null.
  // The args contain the notification-specific data and the notification subscription.
  [webhosthidden]
  delegate void ReactNotificationHandler(Object sender, IReactNotificationArgs args);

  // The notification service is used to subscribe to notifications and to send notifications.
  [webhosthidden]
  interface IReactNotificationService
  {
    // Subscribe to a notification.
    // The notificationName as a property name can belong to a specific namespace. It must be not null.
    // The dispatcher is used to call notification handlers. If it is null, then handler is called synchronously.
    // The handler is a delegate that can be implemented as a lambda to handle notifications.
    // The method returns IReactNotificationSubscription that must be kept alive while the subscription
    // is active. The subscription is removed when the IReactNotificationSubscription is destroyed.
    IReactNotificationSubscription Subscribe(
      IReactPropertyName notificationName, IReactDispatcher dispatcher, ReactNotificationHandler handler);

    // Send the notification with notificationName.
    // The sender is the object that sends notification. It can be null.
    // The data is the data associated with the notification. It can be null.
    // Consider using IReactPropertyBag for sending semi-structured data. It can be created
    // using the ReactPropertyBagHelper.CreatePropertyBag method.
    void SendNotification(IReactPropertyName notificationName, Object sender, Object data);
  }

  // Helper methods for the notification service implementation.
  [webhosthidden]
  static runtimeclass ReactNotificationServiceHelper
  {
    // Create new instance of IReactNotificationService
    static IReactNotificationService CreateNotificationService();
  }
} // namespace Microsoft.ReactNative -->
