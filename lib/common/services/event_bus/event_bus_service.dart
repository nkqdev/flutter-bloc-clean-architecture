import 'package:event_bus/event_bus.dart';

class EventBusService {
  static final EventBus _eventBus = EventBus();

  static EventBus get instance => _eventBus;
}
