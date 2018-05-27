import $ from 'jquery'
import Backbone from 'backbone'
import Marionette from 'backbone.marionette'
import tc from 'teacup'

import NavbarEntry from './entry-model'

MainChannel = Backbone.Radio.channel 'global'

class BaseEntryView extends Marionette.View
  model: NavbarEntry
  tagName: 'li'
  className: 'nav-item'
  templateContext: ->
    app = MainChannel.request 'main:app:object'
    context =
      app: app
      currentUser: app.getState 'currentUser'
    return context
  ui:
    entry: '.navbar-entry'
  triggers:
    'click @ui.entry': 'click:entry'
  set_active: ->
    @$el.addClass 'active'
    return
  unset_active: ->
    @$el.removeClass 'active'
    return
    
class SingleEntryView extends BaseEntryView
  template: tc.renderable (entry) ->
    tc.a '.navbar-entry.nav-link', href:entry.url, ->
      if entry.icon
        tc.i entry.icon
        tc.text " "
      tc.text entry.label

class DropdownEntryView extends BaseEntryView
  className: 'nav-item dropdown'
  ui: ->
    toggleButton: '.dropdown-toggle'
    entry: '.navbar-entry'
  template: tc.renderable (entry) ->
    tc.a '.nav-link.dropdown-toggle',
    role:'button', 'data-toggle':'dropdown', ->
      tc.text entry.label
      tc.b '.caret'
    tc.ul '.dropdown-menu', ->
      for link in entry.menu
        if link?.needUser and not entry.currentUser
          continue
        tc.li ->
          tc.a '.navbar-entry.nav-link.dropdown-item', href:link.url, ->
            if link.icon
              tc.i link.icon
              tc.text " "
            tc.text link.label

class NavbarEntryCollectionView extends Marionette.CollectionView
  tagName: 'ul'
  className: 'navbar-nav'
  
  childView: (item) ->
    if item.has('menu') and item.get('menu')
      DropdownEntryView
    else
      SingleEntryView
      
  setAllInactive: ->
    @children.each (view) ->
      view.unset_active()
    return
      
  onChildviewClickEntry: (cview, event) ->
    @setAllInactive()
    cview.set_active()
    @navigateOnClickEntry cview, event
    return
    
  navigateOnClickEntry: (cview, event) ->
    # FIXME triggering click:entry
    # seems to leave dropdown open
    # this closes the navbar menu
    event.stopPropagation()
    if cview.$el.hasClass "show"
      #cview.$el.dropdown('toggle')
      cview.ui.toggleButton.click()
    target = event.target
    # check if icon is clicked
    if target.tagName is "I"
      #console.warn "clicked icon"
      anchor = $(target).parent()
    else
      anchor = $(target)
    # look at href and go there maybe?
    href = anchor.attr 'href'
    if href.split('/')[0] == ''
      window.location = href
    else
      router = MainChannel.request 'main-router'
      router.navigate href, trigger: true
    return
    
class NavbarEntriesView extends Marionette.View
  ui:
    list: '.navbar-entries'
  regions:
    list: '@ui.list'
    userMenu: '#user-menu'
    search: '#form-search-container'
  onRender: ->
    view = new NavbarEntryCollectionView
      collection: @collection
    @showChildView 'list', view
    return
  template: tc.renderable (model) ->
    tc.div '.navbar-entries.mr-auto'
  setAllInactive: ->
    view = @getChildView 'list'
    view.setAllInactive()
    return
   
    
export default NavbarEntriesView



