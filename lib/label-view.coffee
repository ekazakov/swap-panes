module.exports =
class LabelView
    constructor: (label) ->
        @element = document.createElement('div')
        @element.classList.add('swap-panes')
        label = document.createElement('div')
        label.textContent = label

        @element.appendChild(label)

    # Tear down any state and detach
    destroy: ->
        @element.remove()

    getElement: ->
        @element
