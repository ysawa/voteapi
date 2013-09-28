# -*- coding: utf-8 -*-

module MobileTestHelper
  def fake_as_android
    page.driver.header("User-Agent", 'Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03S) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19')
  end

  def fake_as_iphone
    page.driver.header("User-Agent", 'Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1C28 Safari/419.3')
  end
end
