module FlashContentTags
  
  include Radiant::Taggable
  
  desc %{
    Embed swf file using swfobject
    *Usage:* 
    <pre><code><r:swf [src="path_to_swf_file"] [width] [height]>...</r:swf></code></pre>
  }
  tag 'swf' do |tag|
    s = Swfobject.new
    s.width = tag.attr["width"]
    s.height = tag.attr["height"]
    s.src = tag.attr["src"]
    s.swfobject_src = "/javascripts/radiant-flash_content-extension/swfobject.js"
    s.express_install_src = "/swf/radiant-flash_content-extension/expressInstall.swf"
    s.get tag.expand
  end
  
end
