import $ from 'jquery'
import Backbone from 'backbone'
import Marionette from 'backbone.marionette'
import Toolkit from 'marionette.toolkit'
import tc from 'teacup'

import './dbchannel'
import NavbarHeaderView from './navbar-header'
import NavbarEntriesView from './entries'
import BootstrapNavBarView from './main-view'

class NavbarApp extends Toolkit.App
  onBeforeStart: ->
    appConfig = @options.appConfig
    region = @options.parentApp.getView().getRegion 'navbar'
    @setRegion region
    if appConfig.hasUser
      userMenuApp = @addChildApp 'user-menu',
        AppClass: appConfig.userMenuApp
        startWithParent: true
        appConfig: appConfig
        ,
        parentApp: @
        
  onStart: ->
    # build main page layout
    @initPage()

  initPage: ->
    appConfig = @options.parentApp.options.appConfig
    layout = new BootstrapNavBarView
      model: new Backbone.Model appConfig
    @showView layout

export default NavbarApp


