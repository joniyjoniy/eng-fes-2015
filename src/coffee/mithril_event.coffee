((window) ->
  event = {}
  event.list = m.prop([])

  event.controller = ->
    m.request({
      method: 'GET'
      url: './assets/data/event.json'
      initialValue: []
    }).then((value) ->
      event.list(value);
      m.redraw()
    )

  event.view = () ->
    m('.container', [
      m('.row.m-b-0', [
        event.list().map((item) ->
          m('.col.s12.m6.l4', [
            m('.card', [
              m('.card-image', [
                m('img', {
                  src: "./assets/images/#{item.image}"
                  alt: item.image
                })
              ]),
              m('.card-content', [
                m('.card-title.black-text.m-l-sm', [
                  m('i.fa.m-r-sm', {
                    class: "fa-#{item.icon}"
                  }),
                  m('img', {
                    src: "./assets/images/#{item.banner}"
                    alt: item.banner
                  })
                ]),
                m('p.grey-text.m-t-sm', m.trust(item.description.replace(/\n/g, '<br />')))
              ])
            ])
          ])
        )
      ])
    ])

  m.mount(eventapp, event)
)(window)
