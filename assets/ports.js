window.__ports__ = {
  integrate(app) {

    var player = window.player;

    function sendPlayerStatus() {
      app.ports.playerStatus.send({
        progress: player.getCurrentTime() / player.getDuration(),
        currentTime: player.getCurrentTime(),
        duration: player.getDuration()
      });
    }

    // Publish

    setInterval(function () {
      sendPlayerStatus();
    }, 1000)

    player.addEventListener('onStateChange', function (event) {
      if (event.data === 1) { // it is playing
        sendPlayerStatus();
      }
    });

    // Subscribe

    app.ports.loadVideoById.subscribe(function (id) {
      player.loadVideoById(id)
    })

    app.ports.stopVideo.subscribe(function () {
      player.stopVideo()
    })

    app.ports.playVideo.subscribe(function () {
      player.playVideo()
    })

    app.ports.pauseVideo.subscribe(function () {
      player.pauseVideo()
    })

    app.ports.seekTo.subscribe(function (timeSecs) {
      player.seekTo(timeSecs)
    })
  }
};
