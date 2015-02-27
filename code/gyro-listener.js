if(window.DeviceOrientationEvent) {
  window.addEventListener('deviceorientation', function(event) {
    alpha = event.alpha;        
    beta = event.beta;
    gamma = event.gamma;
  }, false);
}