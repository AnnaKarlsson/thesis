SensorManager sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
Sensor sensor; //the sensor such accelerometer, gyroscope...

if (sensorManager.getDefaultSensor(Sensor.TYPE_OF_SENSOR) != null) {
	// TYPE_OF_SENSOR such TYPE_ACCELEROMETER
    sensor = sensorManager.getDefaultSensor(Sensor.TYPE_OF_SENSOR); 
    sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_XXX);
}

public void onSensorChanged(SensorEvent event){
    // The time in nanoseconds of when the event occurred
    float timestamp = event.timestamp;

    // The measurements values from the sensor that changed
    float a = event.values[0];
    float b = event.values[1];
    float c = event.values[2];
    // and there may be more depending on which
    // sensor that caused the sensor change.
}