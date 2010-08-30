class Swfobject

  attr_accessor :src, 
                :swfobject_src, 
                :express_install_src,
                :width, 
                :height, 
                :flashplayer_version, 
                :params, 
                :flashvars
  
  def initialize
    @src ||= "no_swf_defined.swf"
    @swfobject_src ||= "/javascripts/swfobject.js" # TODO: include js on top with rails helper
    @express_install_src ||= "/swf/expressInstall.swf"
    @flashplayer_version ||= "9.0.0"
    @params ||= {:quality => "best", :loop => "false", :menu => "false", :scale => "noscale", :salign => "tl"}
    @flashvars ||= {}
  end
  
  def get(alternate_content = "")
    id = generate_id

    alternate_content = %{You need Flash Player #{flashplayer_version} +} if alternate_content == ""
      
    code = %{
<div id="#{id}">
  #{alternate_content}
</div>
<script type="text/javascript" src="#{swfobject_src}"></script>
<script type="text/javascript">

#{js_object_from_hash "params", params}
#{js_object_from_hash "flashvars", flashvars}
swfobject.embedSWF("#{src}", "#{id}", "#{width}", "#{height}", "#{flashplayer_version}", "#{express_install_src}", flashvars, params);
</script>
}
  end
  
private
  
  def js_object_from_hash(name, hash)
    code = %{var #{name} = {};
}
  
    hash.each_pair do |key, value|
      code << %{#{name}.#{key} = "#{value}";
}
    end
    
    code
  end
  
  def generate_id
    "flash_" + @src.split("/").last.split(".swf").first
  end
  
end