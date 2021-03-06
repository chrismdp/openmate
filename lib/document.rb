#document lib
require File.expand_path(File.dirname(__FILE__) + '/../required_libs.rb')

class Document < StyledTextCtrl
  
  attr :file_name
  
  def initialize(*args)
    super
    
    @file_name = "Untitled"
    
    line_num_margin = self.text_width(STC_STYLE_LINENUMBER, "_99999")
    self.set_margin_width(0, line_num_margin)
    
    #keywords defined in the keywords method
    self.set_key_words(0, keywords)
    
    self.set_tab_width(4)
    self.set_use_tabs(false)
    self.set_tab_indents(true)
    self.set_back_space_un_indents(true)
    self.set_indent(4)
    self.set_edge_column(80)

    self.set_property("fold","1")
    self.set_property("fold.compact", "0")
    self.set_property("fold.comment", "1")
    self.set_property("fold.preprocessor", "1")

    self.set_margin_width(1, 0)
    self.set_margin_type(1, STC_MARGIN_SYMBOL)
    self.set_margin_mask(1, STC_MASK_FOLDERS)
    self.set_margin_width(1, 20)

    self.marker_define(STC_MARKNUM_FOLDER, STC_MARK_PLUS)
    self.marker_define(STC_MARKNUM_FOLDEROPEN, STC_MARK_MINUS)
    self.marker_define(STC_MARKNUM_FOLDEREND, STC_MARK_EMPTY)
    self.marker_define(STC_MARKNUM_FOLDERMIDTAIL, STC_MARK_EMPTY)
    self.marker_define(STC_MARKNUM_FOLDEROPENMID, STC_MARK_EMPTY)
    self.marker_define(STC_MARKNUM_FOLDERSUB, STC_MARK_EMPTY)
    self.marker_define(STC_MARKNUM_FOLDERTAIL, STC_MARK_EMPTY)
    self.set_fold_flags(16)

    self.set_margin_sensitive(1,1)
    
  end
  
  def set_style(options={})
    
    self.set_edge_mode(STC_EDGE_NONE)
    
    options[:text_colour] ||= 'black'
    options[:background_colour] ||= 'white'
    options[:comment_colour] ||= 'darkgray'
    options[:keyword_colour] ||= 'blue'
    options[:string_colour] ||= 'blue'
    self.style_set_foreground(STC_STYLE_DEFAULT, Wx::Colour.new(options[:text_colour]));
    self.style_set_background(STC_STYLE_DEFAULT, Wx::Colour.new(options[:background_colour]));
    self.style_set_foreground(STC_STYLE_LINENUMBER, LIGHT_GREY);
    self.style_set_background(STC_STYLE_LINENUMBER, WHITE);
    self.style_set_foreground(STC_STYLE_INDENTGUIDE, LIGHT_GREY);
    
    self.set_lexer(STC_LEX_RUBY)
    self.style_clear_all
    self.style_set_foreground(2, Wx::Colour.new(options[:comment_colour]))
    self.style_set_foreground(3, GREEN)
    self.style_set_foreground(5, Wx::Colour.new(options[:keyword_colour]))
    self.style_set_foreground(6, Wx::Colour.new(options[:string_colour]))
    self.style_set_foreground(7, Wx::Colour.new(options[:string_colour]))
    
    font = Font.new(10, TELETYPE, NORMAL, NORMAL)
    self.style_set_font(STC_STYLE_DEFAULT, font);
  end
  
  def set_view_style(style)
    options = case style
    when 'Light' then {:text_colour => 'black', :background_colour => 'white'}
    when 'Dominion' then {:text_colour => '#B9ADD7', :background_colour => 'black',
      :comment_colour => '#554D9D', :keyword_colour => '#5B55FE', :string_colour => '#83529D'}
    else raise 'Unknown view style'
    end
    set_style(options)
  end
  
  def keywords
    "begin break elsif module retry unless end case next return until class ensure nil self when def false not super while alias defined? for or then yield and do if redo true else in rescue undef"
  end
  
  def open
    
  end
  
end