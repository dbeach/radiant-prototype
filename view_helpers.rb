module ViewHelpers
  def params
    request.query.dup
  end
  
  
  # The NavTab Class holds the structure of a navigation tab (including
  # its sub-nav items).
  class NavTab < Array
    attr_reader :name, :proper_name

    def initialize(name, proper_name)
      @name, @proper_name = name, proper_name
    end

    def [](id)
      unless id.kind_of? Fixnum
        self.find {|subnav_item| subnav_item.name.to_s == id.to_s }
      else
        super
      end
    end
  end


  # simple structure for storing the properties of a
  # tab's sub items.
  class NavSubItem
    attr_reader :name, :proper_name, :url

    def initialize(name, proper_name, url = "#")
      @name, @proper_name, @url = name, proper_name, url
    end
  end


  def nav_tabs
    content = NavTab.new(:content, "Content")
    content << NavSubItem.new(:pages, "Pages", "/admin/pages/")
    content << NavSubItem.new(:snippets, "Snippets", "/admin/snippets/")
  
    design = NavTab.new(:design, "Design")
    design << NavSubItem.new(:layouts, "Layouts", "/admin/layouts/")
  
    settings = NavTab.new(:settings, "Settings")
    settings << NavSubItem.new(:users, "Users", "/admin/users/")
    settings << NavSubItem.new(:extensions, "Extensions", "/admin/extensions/")
  
    [content, design, settings]
  end
end

