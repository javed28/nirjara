//
//  ServerUrl.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/15/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation

class ServerUrl {
   static var baseUrl : String = "http://nirjaraapp.com/api/"
   static var graphbaseUrl : String = "http://nirjaraapp.com/api/graph/"
    
   static var paymentUrl : String = "http://nirjaraapp.com/api/mojo/"
   static var accessToken : String = paymentUrl+"access_token.php"
    static var accessTokenIos : String = paymentUrl+"access_token_ios.php"
   static var post_business_payment : String = baseUrl+"post_business_payment.php"
    
    //panchang
    static var tithiUrl : String = "http://nirjaraapp.com/api/tithi/"
    static var get_pachang = tithiUrl+"panchang/panchang.php"
    static var get_pachang_new = tithiUrl+"panchang/panchang_old.php"
    static var register_fcm = baseUrl+"crons/ios/apns.php"
    static var register_fcm_beelive_test = "http://beelive.in/ios_notification/ios/apns.php"
    
    
   
    
   static var loginUrl : String = baseUrl+"user_login.php"
   static var advertiseGlobalUrl : String = baseUrl+"get_advertisement.php"
   static var get_job_available = baseUrl+"get_jobs.php"
   static var get_follower_graph = baseUrl+"get_follower_graph_details.php"
   static var get_follower_graph_new = baseUrl+"get_follower_graph_details_new.php"
   static var get_population_chart = baseUrl+"get_popularity_chart_details.php"
   static var get_chaturmas_location_wise = baseUrl+"get_chaturmas_location_wise.php"
   static var get_vihar_stay_location_wise = baseUrl+"get_vihar_stay_location_wise.php"
   static var get_vihar_all = baseUrl+"get_vihar_all.php"
   static var get_temples_by_location_wise = baseUrl+"get_temples_by_location_wise.php"
   static var get_temples_by_location_wise_ios = baseUrl+"get_temples_by_location_wise_test.php"
   static var get_latest_temple = baseUrl+"get_latest_temple.php"
   static var get_latest_ten_temple = baseUrl+"get_latest_ten_temple.php"
    static var get_all_temple_marker = baseUrl+"get_all_temple_marker.php"
    
   static var get_event = baseUrl+"get_event.php"
   static var get_kids = baseUrl+"get_babynames.php"
   static var get_knowledge = baseUrl+"get_knowledge.php"
   static var get_tapassya_all = baseUrl+"get_tapassya_all.php"
   static var get_tapassya_all_new = baseUrl+"get_tapassya_all_new.php"
    
   static var get_tapasvi_likes_detail_check = baseUrl+"get_tapasvi_likes_detail_check.php"
    
   static var get_tapassya_for_profile = baseUrl+"get_tapassya_for_profile.php"
   static var get_advertisement_calender = baseUrl+"get_advertisement.php"
   static var get_gallery = baseUrl+"get_gallery.php"
   static var get_gallery_by_id = baseUrl+"get_gallery_by_id.php"
   static var get_ten_gallery = baseUrl+"get_ten_gallery.php"
    
   static var get_guru_data = baseUrl+"get_group.php"
   static var get_tapasvi = baseUrl+"get_tapasvi.php"
   static var get_tapasvi_detail_with_like = baseUrl+"get_tapasvi_detail_with_like.php"
   
    
    
   static var get_vrath_pachkan = baseUrl+"get_vrath_pachkan.php"
   static var get_jainmantra = baseUrl+"get_jainmantra.php"
   
   static var get_advertisement_by_member = baseUrl+"get_advertisement_by_member.php"
   
    
   static var get_holiday_destination = baseUrl+"get_holiday_destination.php"
   static var get_car = baseUrl+"get_car.php"
   static var get_mobile_brand = baseUrl+"get_mobile_brand.php"
    static var get_ipad_brand = baseUrl+"get_ipad_brand.php"
    
   static var get_anumodnas = baseUrl + "get_gallery_anumodan.php";
   static var get_darshans = baseUrl + "get_gallery_darshan.php";
   static var get_comments = baseUrl + "get_gallery_comments.php";
   static var get_population_graph = graphbaseUrl + "population_graph.php";
   static var get_followers_graph = graphbaseUrl + "followers_graph.php";
   static var get_tapasvi_comments = baseUrl + "get_tapasvi_comments.php";
   static var get_tapasvi_likes_details = baseUrl + "get_tapasvi_likes_detail.php";
   
   static var get_nearby_active_samaj_sewak = baseUrl + "get_nearby_active_samaj_sewak.php";
    static var post_ipad_enquiry = baseUrl + "post_ipad_enquiry.php";
  
    
   
   static var post_shravak_registration = baseUrl+"post_sravak_reg.php"
   static var post_guru_registration = baseUrl+"post_guru_reg.php"
   static var post_guru_registration_new = baseUrl+"post_guru_reg_new.php"
   
   static var commen_function = baseUrl+"commen_function.php"
    
   static var post_knowledge_url = baseUrl+"post_knowledge.php"
   static var post_add_vihar_url = baseUrl+"post_vihar_stay.php"
   static var post_active_samaj_seva = baseUrl+"post_active_for_samaj.php"
   static var post_security_number = baseUrl+"post_guru_security_contacts.php"
   static var post_add_temple_url = baseUrl+"post_temple.php"
   static var post_add_events = baseUrl+"post_event.php"
    static var post_add_events_ios = baseUrl+"post_events_ios.php"
    
    static var post_anumodnas = baseUrl+"post_gallery_anumodan.php"
    static var post_darshans = baseUrl+"post_gallery_darshan.php"
    static var post_comments = baseUrl+"post_gallery_comments.php"
    static var block_gallery_image = baseUrl+"post_objection.php"
    static var post_tapasvi_likes = baseUrl+"post_tapasvi_likes.php"
    static var post_tapasvi_comments = baseUrl+"post_tapasvi_comments.php"
    static var post_add_tapasya = baseUrl+"post_tapassya.php"
    
    static var forgot_password_url = baseUrl+"post_forget_pass.php"//username=&contact=
    static var post_holiday_url = baseUrl+"post_international_holiday.php"//destination_id=&when=&how_many_people=&no_of_days=&food_preference=&member_name=&member_id=&email_id=
    static var post_offer_url = baseUrl+"post_special_offer.php"//special_offer_id=&member_id=&contact_no=&email_id=&message=done&member_name=
    static var post_iPad_url = baseUrl+"post_ipad_enquiry.php"//ipad_id=&member_id=&from=&to=&city=&message=testing
    static var post_jewellery_url = baseUrl+"post_jwellery_enquiry.php"//jwellery_type=&budget=&member_id=&quantity&bullion=&from=&to=&city=&message=testing
    static var post_wedding_event_url = baseUrl+"post_wedding_ser_enquiry.php"//service_id=&member_id=&date=&city=&message=testing=&budget=
    static var post_new_business_url = baseUrl+"post_business.php"
     static var post_new_business_url_ios = baseUrl+"post_business_ios.php"
    static var post_business_image_ios = baseUrl+"post_business_image_ios.php"
    
    //business_owner_name=abc&business_title=developement&business_description=adasdasdasd&image=abc.jpg&country=99&state=25&city=351&address=asdasdasdasdasd&contact_no=1234567890&email_id=arun@omwebsolution.com&product1=abc&product2=lmn&product3=lkjljl&product4=asdjajsd'
     static var post_car_url = baseUrl+"post_car_enquiry.php"
     static var post_mobile_url = baseUrl+"post_mobile_enquiry.php"
    static var get_special_offer = baseUrl+"get_special_offer.php"
    static var get_guru_contacts = baseUrl+"get_guru_security_contacts.php"
    static var get_special_offer_enquiry = baseUrl+"get_special_offer_enquiry.php"
  
    
    static var deactive_fcm_token = baseUrl+"deactivate_fcm_user.php"
    static var varth_pachkan_notification_api = baseUrl+"vrath_notification.php"
    static var share_app = "https://play.google.com/store/apps/details?id=io.cordova.myapp01e9b4&hl=en"
    static var request_withdraw_my_points = baseUrl+"post_cash_withdrawal_request.php"
    static var check_reference_code = baseUrl+"check_referal_code.php"
    static var get_current_position = baseUrl+"get_current_position.php"
    static var get_current_password = baseUrl+"change_password.php"
    
    static var post_apply_job = baseUrl+"post_apply_job.php"
    static var get_setting_url = baseUrl+"get_notification_on_off.php"
    static var post_setting_url = baseUrl+"notification_on_off.php"
    static var post_hit_count = baseUrl+"adv_hit_counter.php"
    
    
    static var post_guru_tracking = baseUrl+"post_guru_tracking.php"
    static var guru_tracking = baseUrl+"guru_tracking.php"
    
    static var post_job_seeker = baseUrl+"post_jobseeker_details.php"
    static var add_new_job = baseUrl+"post_job.php"
    
    
   
    static var get_user_profile = baseUrl+"get_user_profile.php"
    static var post_user_profile = baseUrl+"post_user_profile.php"
    
    static var my_temple_list = baseUrl+"get_temple_by_member_ios.php"
    static var update_position = baseUrl+"update_position.php"
    
  
    
    // http:nirjaraapp.com/api/vrath_notification.php?longitude=73.76947704&latitude=19.9673897&timezone=Asia/Calcutta&lang=en
 
    
    //withdraw point http:nirjaraapp.com/api/post_cash_withdrawal_request.php?member_id=5&account_number=7894561230&ifsc_code=abc123456&bank_name=sbi&amount=500
   
    
    //post_guru_tracking_of_user member_id=5&main_group_id=2&sub_group_id=4&mod=off
    
    
    
    
    
    //Image Upload Url
    
     static var post_gallery_image_ios = baseUrl+"post_gallery_image_ios.php"
   
    static var upload_user_profile_image = baseUrl+"post_profile_image.php"
    static var upload_user_profile_image_ios = baseUrl+"post_profile_image_ios.php"
    //upload user image url
  
    static var post_temple_image = baseUrl+"post_temple_image.php"
    static var post_temple_image_ios = baseUrl+"post_temple_image_ios.php"
    
    //post temple image
  
    static var post_business_image = baseUrl+"post_business_image.php"
    //post business image
    static var edit_temple_image_ios = baseUrl+"edit_temple_image_ios.php"
    static var edit_temple_image = baseUrl+"edit_temple_image.php"
    
    //Post event image:
    static var post_event_image = baseUrl+"post_event_images.php"
    static var post_event_image_ios = baseUrl+"post_event_images_ios.php"
    
    static var getTimeZone = baseUrl+"getTimeZone.php"
    static var post_Enquiry = baseUrl+"contact_us.php"
    
     static var autoselect = "https://maps.googleapis.com/maps/api/timezone/json?timestamp=1331161200&key=AIzaSyAnGNu7GB2X0ShQT-R6XF7zfyoiEpB_-z8&location="


    
    static var edit_temple = baseUrl+"post_temple_edit.php"
    static var edit_vihar_stay = baseUrl+"post_vihar_stay_edit.php"
    
    static var delete_guru_contact = baseUrl+"delete_guru_security_contacts.php"
    static var edit_guru_contact = baseUrl+"edit_guru_security_contacts.php"
    
    static var get_business_cat = baseUrl + "get_business_cat.php";
    static var get_search_business_url = baseUrl+"post_citywise_business.php"
    static var get_business_cat_home = baseUrl+"get_business_cat_home.php?limit=16"
    static var get_businessowner_url = baseUrl+"get_business.php"
    static var get_business_package_url = baseUrl+"get_package.php"
    static var get_business_category = baseUrl+"get_business_cat.php"
    static var get_business_by_id = baseUrl+"get_business_by_id.php"
    static var get_businessBy_member_wise = baseUrl+"get_business_by_id.php"
    static var edit_my_business = baseUrl+"edit_business.php"
    //static var get_home_page_business_cat = baseUrl+"get_business_cat_home.php?limit=16"
    static var delete_my_business = baseUrl+"delete_business.php"
    static var get_business_cat_search = baseUrl+"get_business_cat_search.php"
    
    static var get_guru_track_status = baseUrl+"get_guru_track_status.php"
    static var post_guru_on_off = baseUrl+"post_guru_on_off.php"
    static var update_adhithana = baseUrl+"update_adhithana.php"
    static var get_vihar_stay_member_wise = baseUrl+"get_vihar_stay_member_wise.php"
    static var delete_vihar_stay = baseUrl+"delete_vihar_stay.php"
    static var post_vihar_stay_edit = baseUrl+"post_vihar_stay_edit.php"
    static var post_language = baseUrl+"post_language.php"
    
    
    //Profile Update
    static var update_community = baseUrl+"get_user_community_update.php"
    static var update_bank_detail = baseUrl+"get_user_bank_update.php"
    static var update_user_personal_detail = baseUrl+"get_user_personal_detail_update.php"
    static var update_user_family_members = baseUrl+"get_user_family_members_update.php"
    static var update_user_knowledge = baseUrl+"get_user_knowledge_update.php"
    static var post_tapassya_count = baseUrl+"post_tapassya_count.php"
    static var get_user_work_update = baseUrl+"get_user_work_update.php"
    static var get_user_workplace_address = baseUrl+"get_user_workplace_address.php"
    static var get_tapasvi_by_id = baseUrl+"get_tapasvi_by_id.php"
    static var update_intro = baseUrl+"update_intro.php"
    static var get_user_city_state_update = baseUrl+"get_user_city_state_update.php"
    
    static var get_tapasvi_by_idd = baseUrl+"get_tapasvi_by_idd.php"
    static var get_like_details_profile = baseUrl+"get_like_details.php"
    static var get_comment_details_profile = baseUrl+"get_comment_details.php"
    
    
}
