module BootstrapHelper

  # Easy macro to render a FontAwesome glyph.
  # font_awesome( 'name_of_glyph', size: 1, spin: true )
  def font_awesome( *args, size: nil, spin: false, style: '', em: nil, **options )
    classes = ['fa'] + args.map{|a| "fa-#{a}"}
    classes << "fa-#{size.to_i}"        if size
    classes << 'fa-spin'                if spin
    classes << options[ :class ].to_s   if options[ :class ]
    style   = [ style, "font-size: #{em}em;" ].join(' ')  if em
    style   = " style='#{style.strip}'"                   if style.present?
    "<i class='#{classes.join(' ')}'#{style}></i>".html_safe
  end

  def alert_dismiss_button
    "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>".html_safe
  end

  def button( *args, **options, &block )
    options[ :class ] ||= 'btn btn-default'
    options[ :type  ] ||= 'button'
    block_given? ? button_tag( options, &block ) : button_tag( args.first, options )
  end

  def submit_button( *args, **options, &block )
    options[ :class ] ||= 'btn btn-primary'
    options[ :type  ]   = 'submit'
    block_given? ? button_tag( options, &block ) : button_tag( args.first, options )
  end

end
