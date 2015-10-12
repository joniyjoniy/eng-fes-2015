((window) ->
  stall = {}
  stall.list = m.prop([])

  stall.controller = ->
    m.request({
      method: 'GET'
      url: './assets/data/stall.json'
      initialValue: []
    }).then((value) ->
      stall.list(value);
      m.redraw()
    )

  stall.view = () ->
    m('.container', [
      m('.section-title.brand-darker-text.m-b-sm.m-l-sm', [
        m('i.fa.fa-cutlery.m-r-sm'),
        m('img.shadow[src=./assets/images/stall.png][alt=stall.png]')
      ])
      m('.row.m-b-0', [
        stall.list().map((item) ->
          m('.col.s12.m6.l3', [
            m('.card', [
              m('.card-image', [
                m('img', {
                  src: "./assets/images/#{item.image}"
                  alt: item.image
                })
              ]),
              m('.card-content.p-a-0', [
                m('ul.collection.no-border.m-a-0', [
                  m('li.collection-item.center', [
                    m('span.title.bold', item.title)
                  ])
                  # item.menus.map((menu) ->
                  #   m('li.collection-item', [
                  #     menu.name
                  #     m('.secondary-content.grey-text', [
                  #       m('i.fa.fa-jpy'),
                  #       String(menu.price)
                  #     ])
                  #   ])
                  # )
                ])
              ]),
            ])
          ])
        )
      ])
    ])

  m.mount(stallapp, stall)
)(window)
