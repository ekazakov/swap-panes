SwapPanesView = require './swap-panes-view'
{CompositeDisposable} = require 'atom'

module.exports = SwapPanes =
  swapPanesView: null
  modalPanel: null
  subscriptions: null
  isActive: false

  activate: (state) ->
    @swapPanesView = new SwapPanesView(state.swapPanesViewState)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add('atom-workspace', 'swap-panes:toggle': => @toggle())
    @subscriptions.add atom.commands.add('atom-workspace', 'keydown': (event) => @log(event))

  deactivate: ->
    # @modalPanel.destroy()
    @subscriptions.dispose()
    @swapPanesView.destroy()

  log: (event) ->
    if @isActive
        event.stopImmediatePropagation()
        event.preventDefault()
        @paneElement.removeChild @swapPanesView.getElement()
        console.log(event)
        @isActive = false


  toggle: ->
      pane = atom.workspace.getActivePane()
      @paneElement = atom.views.getView(pane)

      if not @isActive
        @paneElement.appendChild @swapPanesView.getElement()
        @isActive = true
      else
        @isActive = false
        @paneElement.removeChild @swapPanesView.getElement()


    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   editor = atom.workspace.getActiveTextEditor()
    #   words = editor.getText().split(/\s+/).length
    #
    #   @swapPanesView.setCount(words)
    #   @modalPanel.show()
