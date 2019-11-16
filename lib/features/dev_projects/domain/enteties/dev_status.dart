enum DevStatus {
  IDEA, DEVELOPMENT, FINISHED
}

class DevStatusHelper {

  static int value(DevStatus status){
    switch(status) {
      case DevStatus.IDEA: return 0;
      case DevStatus.DEVELOPMENT: return 1;
      case DevStatus.FINISHED: return 2;
      default: throw new ArgumentError("Invalid argument");
    }
  }

  static DevStatus fromValue(int value){
    switch(value){
      case 0: return DevStatus.IDEA;
      case 1: return DevStatus.DEVELOPMENT;
      case 2: return DevStatus.FINISHED;
      default: throw new ArgumentError("Invalid argument");
    }
  }
}