import Backbone from 'backbone'

export default class NavbarEntry extends Backbone.Model
  defaults:
    label: 'App Label'
    url: '#app'
    single_applet: false
    applets: []
    urls: []
