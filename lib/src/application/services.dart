// Copyright (c) 2012, the Lihtium-Ion Engine project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_application;

/// Interface for a service.
///
/// [Service]s are a way to provide loose coupling between objects that need
/// to interact with each other. Providers register with the [Services] class,
/// through the [Services.addService] method. After registration the [Service]
/// can be queried through [Services.getService].
class Service { }

/// A mediator for accessing [Service]s.
///
/// Provides a single point to register and access [Service]s within an
/// [Application].
class Services {
  GraphicsDeviceManager _graphicsDeviceManager;

  GraphicsDeviceManager get graphicsDeviceManager => _graphicsDeviceManager;

  /// Registers a [Service] with the container.
  void addService(Service service) {
    if (service is GraphicsDeviceManager) {
      _graphicsDeviceManager = service;
    }
  }

  /// Retrieves a [Service] by using a runtime [type].
  Service getService(Type type) {

  }

  /// Removes the [Service] from the container.
  void removeService(Service service) {

  }
}
