require File.dirname(__FILE__) + '/../spec_helper'

describe FlashContentTags do
  dataset :pages
  
  describe "<r:swf>" do
    
    it "should render correct code" do
      tag = %{<r:swf src="flash.swf" width="123" height="123" />}
      
      expected = %{
<div id="flash_flash">
  You need Flash Player 9.0.0 +
</div>
<script type="text/javascript" src="/javascripts/radiant-flash_content-extension/swfobject.js"></script>
<script type="text/javascript">

var params = {};
params.quality = "best";
params.loop = "false";
params.menu = "false";
params.salign = "tl";
params.scale = "noscale";

var flashvars = {};

swfobject.embedSWF("flash.swf", "flash_flash", "123", "123", "9.0.0", "/swf/radiant-flash_content-extension/expressInstall.swf", flashvars, params);
</script>
}

    pages(:home).should render(tag).as(expected)
    end
        
  end
end
