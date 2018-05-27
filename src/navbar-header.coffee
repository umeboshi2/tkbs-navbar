import Backbone from 'backbone'
import Marionette from 'backbone.marionette'
import tc from 'teacup'

import NavbarToggleButton from './toggle-button'

class NavbarHeaderView extends Marionette.View
  template: tc.renderable (model) ->
    tc.a '.navbar-brand', href:model.url, model.label
    tc.div '.toggle-container'
  ui:
    brand: '.navbar-brand'
    toggleContainer: '.toggle-container'
  regions:
    toggleContainer: '@ui.toggleContainer'
  triggers:
    'click @ui.brand': 'click:brand'
  onRender: ->
    view = new NavbarToggleButton
    @showChildView 'toggleContainer', view
    

    

    
export default NavbarHeaderView



