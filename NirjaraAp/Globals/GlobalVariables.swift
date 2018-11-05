//
//  GlobalVariables.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/4/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation

class GlobalVariables{
    static var TempleState = ""
    static var selectedLanguage = "hi"
    static var orangeColor = "#FF9800"
    static var titleColor = "#002866"
    static var mapbelowColor = "#939393"
    static var lightgray = "#e0e0e0"
    
    
    static var fullPageAdd : NSMutableArray = NSMutableArray()
    
    //static var GoogleMapsKey = "AIzaSyC3lkZSeges1J_b_-7Skd-z1EE2Iwwag3Y"
     static var GoogleMapsKey = "AIzaSyDaKAyRhKGkysOHQx9DQHQIuQ0LmXF3K9M"
    
    static var addknowledge = ""
    static var currentLat = "0.0"
    static var currentLong = "0.0"
    static var currentAddres = ""
    static var fontSize : Int = 18
    static var ButtonofTable : Int = 14
    static var TitleOfButtonOnTable : Int = 15
    static var locationUpdatedOneTime : Bool = true
    
    
    //Profile Data
    
    
    static var main_group_id = ""
    static var profileImage = ""
    static var main_group_name = ""
    static var sub_group_id = ""
    static var sub_group_name = ""
    static var religion = ""
    
    static var state_id = ""
    static var state = ""
    static var city_id = ""
    static var member_city = ""
    static var work = ""
    static var work_address = ""
    
    static var slogan = ""
    static var kids1_name = ""
    static var kids2_name = ""
    static var kids3_name = ""
    static var fathers_name = ""
    static var mothers_name = ""
    static var wife_name = ""
    
    static var bank_name = ""
    static var ifsc = ""
    static var account_number = ""
    
    static var member_name = ""
    static var email_id = ""
    static var contact = ""
    static var dob = ""
    static var rupee = "\u{20B9}"
    //Edit Temple Image
    
    static var editTempleImage = ""
    
    //Active Samaj Seva
    static var selectedDate = ""
    static var selectedTimeFrom = ""
    static var selectedTimeTo = ""
    //End Active Samaj Seva
    
    //Business Cateorgy
    //City Name ID
    static var business_cat_id = [String]()
    static var business_category = [String]()
    
    //City Name ID
    static var cityName = [String]()
    static var cityId = [String]()
    
    //State Name Id
    
    static var stateName = [String]()
    static var stateId = [String]()
    
    //Add Events
    static var selectedEventsDateFrom = ""
    static var selectedEventsDateTo = ""
    static var selectedEventsTimeFrom = ""
    static var selectedEventsTimeTo = ""
    //End Events
    
    //Internation Holiday
    static var selectedHolidayDateFrom = ""
    //End
    
    //Cars holiday
    static var selectedCarsFrom = ""
    static var selectedCarsTo = ""
    //End Holiday
    
    //Mobile Purchase
    static var selectedMobileFrom = ""
    static var selectedMobileTo = ""
    //Mobile End
    //Mobile Purchase
    static var selectedIpadFrom = ""
    static var selectedIpadTo = ""
    //Mobile End
    
    //Jewerralry Purchase
    static var selectedJewerallyFrom = ""
    static var selectedJewerallyTo = ""
    //Jewerralry End
    
    static var  kMapStyle = ""
    static var  kMapStyle1 = "[" +
        "  {" +
        "    \"featureType\": \"all\"," +
        "    \"elementType\": \"geometry\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#242f3e\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"all\"," +
        "    \"elementType\": \"labels.text.stroke\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"lightness\": -80" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"administrative\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#746855\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"administrative.locality\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#d59563\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"poi\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#d59563\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"poi.park\"," +
        "    \"elementType\": \"geometry\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#263c3f\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"poi.park\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#6b9a76\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road\"," +
        "    \"elementType\": \"geometry.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#2b3544\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#9ca5b3\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.arterial\"," +
        "    \"elementType\": \"geometry.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#38414e\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.arterial\"," +
        "    \"elementType\": \"geometry.stroke\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#212a37\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.highway\"," +
        "    \"elementType\": \"geometry.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#746855\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.highway\"," +
        "    \"elementType\": \"geometry.stroke\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#1f2835\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.highway\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#f3d19c\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.local\"," +
        "    \"elementType\": \"geometry.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#38414e\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"road.local\"," +
        "    \"elementType\": \"geometry.stroke\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#212a37\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"transit\"," +
        "    \"elementType\": \"geometry\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#2f3948\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"transit.station\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#d59563\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"water\"," +
        "    \"elementType\": \"geometry\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#17263c\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"water\"," +
        "    \"elementType\": \"labels.text.fill\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"color\": \"#515c6d\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"water\"," +
        "    \"elementType\": \"labels.text.stroke\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"lightness\": -20" +
        "      }" +
        "    ]" +
        "  }" +
    "]"
}
