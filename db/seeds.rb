# -*- encoding : utf-8 -*-
Chufa.create!([
  { :name => "北京"},
  { :name => "广州"},
  { :name => "天津"},
  { :name => "沈阳"},
  { :name => "石家庄"},
  { :name => "青岛"},
  { :name => "大连"},
  { :name => "太原"},
  { :name => "上海"},
])
Product.create!([
  { :name => "出境跟团游" },
  { :name => "国内跟团游" },
  { :name => "自由人" },
  { :name => "签证" },
])
Destcat.create!([
  { :name => "美洲", :dests_attributes => [
    { :name => "美国"  },
    { :name => "巴西"  },
    { :name => "阿根廷"  },
    { :name => "加拿大"  },
  ]},
  { :name => "欧洲", :dests_attributes => [
    { :name => "英国"  },
    { :name => "德国"  },
    { :name => "意大利"  },
    { :name => "爱尔兰"  },
    { :name => "马其顿"  },
    { :name => "荷兰"  },
    { :name => "葡萄牙"  },
    { :name => "希腊"  },
    { :name => "丹麦"  },
    { :name => "波兰"  },
    { :name => "瑞典"  },
    { :name => "挪威"  },
    { :name => "比利时"  },
    { :name => "奥地利"  },
    { :name => "马尔他"  },
    { :name => "匈牙利"  },
    { :name => "冰岛"  },
  ]},
  { :name => "大洋洲", :dests_attributes => [
    { :name => "关岛" },
    { :name => "澳大利亚" },
    { :name => "汤加" },
    { :name => "马绍尔群岛" },
    { :name => "美属萨摩亚" },
    { :name => "图瓦卢" },
    { :name => "所罗门群岛" },
    { :name => "新西兰" },
    { :name => "瓦努阿图" },
  ]},
  { :name => "中东非洲", :dests_attributes => [
    { :name => "巴勒斯坦" },
    { :name => "以色列" },
    { :name => "黎巴嫩" },
    { :name => "埃及" },
    { :name => "沙特" },
    { :name => "约旦" },
  ]},
  { :name => "东南亚", :dests_attributes => [
    { :name => "泰国"  },
    { :name => "新加坡"  },
    { :name => "马来西亚"  },
    { :name => "菲律宾"  },
  ]},
  { :name => "南亚" },
  { :name => "日韩朝鲜", :dests_attributes => [
    { :name => "日本"  },
    { :name => "韩国"  },
    { :name => "朝鲜"  },
  ]},
  { :name => "马代" },
  { :name => "塞班" },
  { :name => "亚洲及其他", :dests_attributes => [
    { :name => "中国" },
    { :name => "广东" },
    { :name => "上海" },
  ]},
  { :name => "港澳台", :dests_attributes => [
    { :name => "香港" },
    { :name => "澳门" },
    { :name => "台湾" },
  ]},
])
Linetype.create!([
  { :name => "周边" },
  { :name => "特价" },
  { :name => "海岛" },
  { :name => "亲子" },
  { :name => "包机" },
  { :name => "修学" },
  { :name => "专列" },
])
Linename.create!([
  { :name => "马尔代夫天堂岛四晚六天自助游" },
  { :name => "欧洲十国14日" },
  { :name => "泰国一地六日" },
  { :name => "澳大利亚 凯恩斯九日" },
  { :name => "美国东西海岸 夏威夷14天" },
  { :name => "泰国 新加坡 马来西亚十日" },
  { :name => "成都/峨嵋山/乐山卧飞5天" },
])
Pifa.create!([
  { :name => "阳光假期" },
  { :name => "春之旅" },
  { :name => "逍遥假期" },
  { :name => "华远国旅" },
  { :name => "南亚风情" },
  { :name => "皇家旅游" },
  { :name => "天赋之旅" },
])
Star.create!([
  { :name => "一星" },
  { :name => "二星" },
  { :name => "四星" },
  { :name => "五星" },
  { :name => "三星" },
])
House.create!([
  { :name => "高级间" },
  { :name => "标准间" },
  { :name => "水上屋" },
  { :name => "沙滩别墅" },
])
Visatype.create!([
  { :name => "个人旅游签证" },
  { :name => "商务签" },
  { :name => "探亲访友签" },
  { :name => "劳务签" },
])
Guonei.create!([
  { :pifa_id => Pifa.last.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.last.id  ,:days => 6 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
  { :pifa_id => Pifa.first.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.first.id  ,:days => 10 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
])
Guoneifatuan.create!([
  { :guonei_id => Guonei.first.id, :star_id => Star.last.id, :fatuanri => "每周星期五", :daystart => "2011-12-11", "dayend" => "2011-12-20", :left => 8, :total => 50, :tonghang => 500, :zhike => 600 },
  { :guonei_id => Guonei.last.id, :star_id => Star.first.id, :fatuanri => "天天发团", :daystart => "2011-11-01", "dayend" => "2011-11-30", :left => 13, :total => 15, :tonghang => 2680, :zhike => 600 },
])

Chujing.create!([
  { :pifa_id => Pifa.last.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.last.id  ,:days => 6 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
  { :pifa_id => Pifa.first.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.first.id  ,:days => 10 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
])
Chujingfatuan.create!([
  { :chujing_id => Chujing.first.id, :star_id => Star.last.id, :fatuanri => "每周星期五", :daystart => "2011-12-11", "dayend" => "2011-12-20", :left => 8, :total => 50, :tonghang => 500, :zhike => 600 },
  { :chujing_id => Chujing.last.id, :star_id => Star.first.id, :fatuanri => "天天发团", :daystart => "2011-11-01", "dayend" => "2011-11-30", :left => 13, :total => 15, :tonghang => 2680, :zhike => 600 },
])
Zhiyou.create!([
  { :pifa_id => Pifa.last.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.last.id  ,:days => 6 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
  { :pifa_id => Pifa.first.id ,:chufa_id => Chufa.first.id, :linename_id => Linename.first.id  ,:days => 10 ,:detail => "A. 泡 亚洲罕见的天然山顶温泉 B. 玩 尽情玩转现实版的开心农场 C. 赏 国家级的龙门农民画博物馆 10:00 抵达景区参观国家级的龙门农民画博物馆，2010年，国家级农民画博物馆在惠州天然温泉度假村落成，龙门农民画，被誉为“岭南奇葩”，取材于古老的民间故事、传说和现实 生活，以其色彩明艳、图饱满、浓墨重彩、夸张变形的独特艺术风格，深刻反映出当地独特的文化和人民群众对生活的热爱。"   },
])
Zhiyoufatuan.create!([
  { :zhiyou_id => Zhiyou.first.id, :foods => "FB", :house_id => House.first.id, :star_id => Star.last.id, :fatuanri => "每周星期五", :daystart => "2011-12-11", "dayend" => "2011-12-20", :left => 8, :total => 50, :tonghang => 500, :zhike => 600 },
  { :zhiyou_id => Zhiyou.last.id, :house_id => House.last.id, :foods => "HB", :star_id => Star.first.id, :fatuanri => "天天发团", :daystart => "2011-11-01", "dayend" => "2011-11-30", :left => 13, :total => 15, :tonghang => 2680, :zhike => 600 },
])
Qianzheng.create!([
  { :pifa_id => Pifa.first.id, :days => 5,:songqiandi => "北京", :songqianguo => "美国", :visatype_id => Visatype.first.id, :document => "个人资料表", :detail => "个人资料表", :linename_id => Linename.first.id, :tonghang => 2680, :zhike => 600,:daystart => "2011-11-01", "dayend" => "2011-11-30"},
  { :pifa_id => Pifa.first.id, :songqiandi => "上海",:days => 10, :songqianguo => "英国", :visatype_id => Visatype.first.id, :document => "个人资料表", :detail => "个人资料表", :linename_id => Linename.first.id, :tonghang => 2680, :zhike => 600,:daystart => "2011-11-01", "dayend" => "2011-11-30"}
])
