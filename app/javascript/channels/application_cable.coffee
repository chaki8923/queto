#= require cable

@App = {}
App.cable = Cable.createConsumer("ws://localhost:3000/cable")