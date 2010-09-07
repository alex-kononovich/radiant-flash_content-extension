class Swfobject

  attr_accessor :src, 
                :swfobject_src, 
                :express_install_src,
                :width, 
                :height, 
                :flashplayer_version, 
                :params, 
                :flashvars,
                :use_static_publishing_method
  
  def initialize
    @src ||= "no_swf_defined.swf"
    @swfobject_src ||= "/javascripts/swfobject.js" # TODO: include js on top with rails helper
    @express_install_src ||= "/swf/expressInstall.swf"
    @flashplayer_version ||= "9.0.0"
    @params ||= {:quality => "best", :loop => "false", :menu => "false", :scale => "noscale", :salign => "tl"}
    @flashvars ||= {}
    @use_static_publishing_method = false
  end
  
  def get(alternate_content = "")
    id = generate_id
    alternate_content = %{You need Flash Player #{flashplayer_version} +} if alternate_content == ""
    use_static_publishing_method ? 
        get_static_publishing_code(id, alternate_content) 
        : 
        get_dynamic_publishing_code(id, alternate_content)
  end
  
private

  def get_static_publishing_code(id, alternate_content)
    flash_vars_query_string = @flashvars.to_query
%{
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="#{width}" height="#{height}" id="#{id}" align="middle">
	<param name="movie" value="#{src}" />
	#{get_html_params}
	<param name="flashvars" value="#{flash_vars_query_string}" />
	<!--[if !IE]>-->
	<object type="application/x-shockwave-flash" data="#{src}" width="#{width}" height="#{height}">
		<param name="movie" value="#{src}" />
  	#{get_html_params}
		<param name="flashvars" value="#{flash_vars_query_string}" />
	<!--<![endif]-->
#{alternate_content}
	<!--[if !IE]>-->
	</object>
	<!--<![endif]-->
</object>
}
  end
  
  def get_dynamic_publishing_code(id, alternate_content)
%{
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
  
  def get_html_params
    code = ""
    @params.each_pair do |name, value|
      code << %{<param name="#{name}" value="#{value}" />}
    end
    code
  end
  
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