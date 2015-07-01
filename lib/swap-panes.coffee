LabelView = require './label-view'
KEYS = require './key-codes'

{CompositeDisposable} = require 'atom'

LABELS = ['A', 'S', 'D', 'F', 'J', 'K', ';', 'W', 'E', 'I', 'O']

module.exports = SwapPanes =
    swapPanesView: null
    modalPanel: null
    subscriptions: null
    isActive: false
    timeout: null

    activate: (state) ->
        # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
        @subscriptions = new CompositeDisposable

        # Register command that toggles this view
        @subscriptions.add atom.commands.add('atom-workspace', 'swap-panes:toggle': => @toggle())
        @subscriptions.add atom.commands.add('atom-workspace', 'keydown': @onKeyDown.bind(@))

    deactivate: ->
        @subscriptions.dispose()
        @swapPanesView.destroy()

    hide: ->
        @items.forEach (item) -> item.labelView.destroy()
        @isActive = false
        clearTimeout @timeout

    onKeyDown: (event) ->
        if @isActive
            event.stopImmediatePropagation()
            event.preventDefault()

            item = @items.filter((item) -> item.key == event.keyCode)[0]
            item.paneView.focus() if item
            @hide()

    toggle: ->
        if not @isActive
            @isActive = true
            panes = atom.workspace.getPanes();

            # @timeout = setTimeout (=> @hide()), 3000
            @items = panes.map (pane, index) ->
                label = LABELS[index]
                labelView = new LabelView(label)
                paneView = atom.views.getView(pane)
                paneView.appendChild labelView.getElement()

                label: label
                key: KEYS[label]
                pane: pane
                paneView: paneView
                labelView: labelView
        else
            @isActive = false
