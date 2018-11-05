//
//  OtherImageUploadCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/27/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import Alamofire
import JHTAlertController
import YPImagePicker
import Photos

class OtherImageUploadCntr: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var imgSelected: UIImageView!
    
    @IBOutlet weak var btnUploadphoto: UIButton!
  
    var whatToUpload = String()
    var eventId = String()
    var templeId = String()
    var businessId = String()
    var templeImageId = String()
    var pickerController = UIImagePickerController()
    var containerController: ContainerViewController?
    
    @IBOutlet weak var btnSkipUpload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Image Upload"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:8))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:8,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
       // self.navigationController?.viewControllers.remove(at: 1)
        self.updateBackButton()
       
        imgSelected.frame = CGRect(x:10,y:100,width:self.view.frame.width-20,height:310)
        btnTakePhoto.frame = CGRect(x:5,y:self.view.frame.height-110,width:self.view.frame.width/2-5,height:60)
        btnUploadphoto.frame = CGRect(x:self.view.frame.width/2+5,y:self.view.frame.height-110,width:self.view.frame.width/2-10,height:60)
        btnSkipUpload.frame = CGRect(x:self.view.frame.width-170,y:self.view.frame.height-150,width:160,height:50)
        btnTakePhoto.setTitle("TakePhoto".localized1, for: .normal)
        btnUploadphoto.setTitle("Upload".localized1, for: .normal)
        containerController = revealViewController().frontViewController as? ContainerViewController
        btnSkipUpload.addTarget(self, action: #selector(skipUpload(_:)), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
   @objc func skipUpload(_ sender : UIButton){
    if(whatToUpload == "Business"){
       // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "makePaymentIdenfier") as? MakePaymentCntr
        gotoOtherUpload?.businessId = String(describing: businessId)
        self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
    }else{
        self.navigationController?.popViewController(animated: true)
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeImageClicked(_ sender: Any) {
//        let img = UIImagePickerController()
//        img.delegate = self
//        img.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        img.allowsEditing = false
//        self.present(img,animated: true)
      /*  let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.openCamera()
        })
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
            self.openGallary()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        alertViewController.addAction(camera)
        alertViewController.addAction(gallery)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated: true, completion: nil)*/
        self.imgSelected.image = nil;
        /*let fusuma = FusumaViewController()
        
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = false
        //        fusuma.availableModes = [.video]
       // fusumaSavesImage = true
        
        self.present(fusuma, animated: true, completion: nil)*/
        var config = YPImagePickerConfiguration()
        config.onlySquareImagesFromLibrary = false
        config.onlySquareImagesFromCamera = true
        config.libraryTargetImageSize = .original
        config.usesFrontCamera = true
        config.showsFilters = false
       // config.shouldSaveNewPicturesToAlbum = true
        //config.videoCompression = AVAssetExportPresetHighestQuality
        config.albumName = "Nirjara App"
        config.screens = [.library, .photo]
        config.startOnScreen = .library
        //config.videoRecordingTimeLimit = 10
        //config.videoFromLibraryTimeLimit = 20
        //config.showsCrop = .rectangle(ratio: (16/16))
        //config.wordings.libraryTitle = "Gallery"
        //config.hidesStatusBar = false
        //config.overlayView = myOverlayView
        
        // Build a picker with your configuration
        let picker = YPImagePicker(configuration: config)
        picker.didSelectImage = { [unowned picker] img in
            // image picked
            print(img.size)
            self.imgSelected.image = img
            picker.dismiss(animated: true, completion: nil)
        }
        //        picker.didSelectVideo = { videoData, videoThumbnailImage in
        //            // video picked
        //            self.imageView.image = videoThumbnailImage
        //            picker.dismiss(animated: true, completion: nil)
        //        }
        //        picker.didCancel = {
        //            print("Did Cancel")
        //        }
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func uploadImg(_ sender: Any) {
        
        if(imgSelected.image == nil){
            self.showAlert(title: "Warning", message: "Please Select Some Image First")
        }else{
            if isConnectedToNetwork() {
        if(whatToUpload == "Events"){
            
            uploadEventsImg()
        }else if (whatToUpload == "Profile"){
            uploadUserImg()
        }
        else if (whatToUpload == "templeEditImage"){
            uploadEditTempleImage()
        }
        else if (whatToUpload == "Business"){
            uploadBusinessImg()
        }
        else{
           uploadTemplesImg()
        }
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }

      }
    }
    override func viewWillAppear(_ animated: Bool) {
        photoLibraryAvailabilityCheck()
    }
    
    func photoLibraryAvailabilityCheck()
    {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized
        {
            
        }
        else
        {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    func requestAuthorizationHandler(status: PHAuthorizationStatus)
    {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized
        {
            
        }
        else
        {
            alertToEncouragePhotoLibraryAccessWhenApplicationStarts()
        }
    }
    
    func alertToEncourageCameraAccessWhenApplicationStarts()
    {
        //Camera not available - Alert
        let internetUnavailableAlertController = UIAlertController (title: "Camera Unavailable", message: "Please check to see if it is disconnected or in use by another application", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) //(url as URL)
                }
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        
        internetUnavailableAlertController .addAction(cancelAction)
        internetUnavailableAlertController .addAction(settingsAction)
        
        
        self.present(internetUnavailableAlertController, animated: true, completion: nil)
    }
    func alertToEncouragePhotoLibraryAccessWhenApplicationStarts()
    {
        //Photo Library not available - Alert
        let cameraUnavailableAlertController = UIAlertController (title: "Photo Library Unavailable", message: "Please check to see if device settings doesn't allow photo library access", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        
        cameraUnavailableAlertController .addAction(cancelAction)
        cameraUnavailableAlertController .addAction(settingsAction)
        
        self.present(cameraUnavailableAlertController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            pickerController.delegate = self
            self.pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = false
            self .present(self.pickerController, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "warning", message: "You don't have camera")
        }
    }
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerController.allowsEditing = false
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    func uploadEditTempleImage(){
        
        self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!
        
        let parameters = ["member_id": UserDefaults.standard.getUserID(),"temple_id":templeImageId,"temple_photo":"image1"]
        print("Edit Temple==",parameters)
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:ServerUrl.edit_temple_image)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON {
                    response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        let response = JSON as! NSDictionary
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        //example if there is an id
                        let message = response.object(forKey: "message") as? String
                        if(message == "success"){
                            DispatchQueue.main.async {
                                // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                                let editTempleImage = response.object(forKey: "result") as? String
                                GlobalVariables.editTempleImage = editTempleImage!
                                let alertController = JHTAlertController(title: "Success", message:"Temple Image Updated Successfuly", preferredStyle: .alert)
                                
                                alertController.titleTextColor = .black
                                alertController.titleFont = .systemFont(ofSize: 18)
                                alertController.titleViewBackgroundColor = .white
                                alertController.messageTextColor = .black
                                alertController.alertBackgroundColor = .white
                                alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                                
                                let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                    self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[8])
                                    self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                    
                                }
                                alertController.addAction(okAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }else{
                            self.showAlert(title: "Failed", message: "Image Uploaded Failed")
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        print("Request failed with error: \(error)")
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    
    func uploadEventsImg(){
        
        self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!
        
        let parameters = ["member_id": UserDefaults.standard.getUserID(),"events_id": eventId,"event_photo":"image1"]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "file", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:ServerUrl.post_event_image)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON {
                    response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        let response = JSON as! NSDictionary
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        //example if there is an id
                        let message = response.object(forKey: "message") as? String
                        if(message == "success"){
                            DispatchQueue.main.async {
                                // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                                
                                let alertController = JHTAlertController(title: "Success", message:"Events Image Updated Successfuly", preferredStyle: .alert)
                                
                                alertController.titleTextColor = .black
                                alertController.titleFont = .systemFont(ofSize: 18)
                                alertController.titleViewBackgroundColor = .white
                                alertController.messageTextColor = .black
                                alertController.alertBackgroundColor = .white
                                alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                                
                                let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                    self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[14])
                                    self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                    
                                    
                                }
                                alertController.addAction(okAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }else{
                            self.showAlert(title: "Failed", message: "Image Uploaded Failed")
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        print("Request failed with error: \(error)")
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    func uploadBusinessImg(){
        
        self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!
        
        let parameters = ["member_id": UserDefaults.standard.getUserID(),"business_id": businessId]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:ServerUrl.post_business_image_ios)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON {
                    response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        let response = JSON as! NSDictionary
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        //example if there is an id
                        let message = response.object(forKey: "message") as? String
                        if(message == "success"){
                            DispatchQueue.main.async {
                                // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                                
                                let alertController = JHTAlertController(title: "Success", message:"Business Image Added Successfuly", preferredStyle: .alert)
                                
                                alertController.titleTextColor = .black
                                alertController.titleFont = .systemFont(ofSize: 18)
                                alertController.titleViewBackgroundColor = .white
                                alertController.messageTextColor = .black
                                alertController.alertBackgroundColor = .white
                                alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                                
                                let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                    
                                    let gotoOtherUpload = self.storyboard?.instantiateViewController(withIdentifier: "makePaymentIdenfier") as? MakePaymentCntr
                                    gotoOtherUpload?.businessId = String(describing: self.businessId)
                                    
                                    self.navigationController?.pushViewController(gotoOtherUpload!, animated: true)
                                    //self.navigationController?.popViewController(animated: true)
//                                    self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
//                                    self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[14])
//                                    self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                    
                                    
                                }
                                alertController.addAction(okAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }else{
                            self.showAlert(title: "Failed", message: "Image Uploaded Failed")
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        
                        print("Request failed with error: \(error)")
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    
    func uploadTemplesImg(){
        
        self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!
        
        let parameters = ["member_id": UserDefaults.standard.getUserID(),"temple_id": templeId,"temple_photo":"image1"]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:ServerUrl.post_temple_image_ios)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON {
                    response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        let response = JSON as! NSDictionary
                        
                        //example if there is an id
                        let message = response.object(forKey: "message") as? String
                        if(message == "success"){
                            DispatchQueue.main.async {
                                // self.showAlert(title: "Success", message: "Image Uploaded Successfuly")
                                
                                let alertController = JHTAlertController(title: "Success", message:"Image Uploaded Successfuly", preferredStyle: .alert)
                                
                                alertController.titleTextColor = .black
                                alertController.titleFont = .systemFont(ofSize: 18)
                                alertController.titleViewBackgroundColor = .white
                                alertController.messageTextColor = .black
                                alertController.alertBackgroundColor = .white
                                alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))
                                
                                let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                    self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[8])
                                    self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                    
                                    
                                }
                                alertController.addAction(okAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }else{
                            self.showAlert(title: "Failed", message: "Image Uploaded Failed")
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        print("Request failed with error: \(error)")
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    func uploadUserImg(){
        
        self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!
        
        let parameters = ["member_id": UserDefaults.standard.getUserID()]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:ServerUrl.upload_user_profile_image_ios)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON {
                    response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        let response = JSON as! NSDictionary
                        
                        //example if there is an id
                        let message = response.object(forKey: "message") as? String
                        if(message == "success"){
                            DispatchQueue.main.async {
                                 let userImage = response.object(forKey: "result") as? String
                                GlobalVariables.profileImage = userImage!
                              //   self.showAlert(title: "Success", message: "Profile Image Uploaded Successfuly")
                                
                                let alertController = JHTAlertController(title: "Success", message:"Profile Image Uploaded Successfuly", preferredStyle: .alert)

                                alertController.titleTextColor = .black
                                alertController.titleFont = .systemFont(ofSize: 18)
                                alertController.titleViewBackgroundColor = .white
                                alertController.messageTextColor = .black
                                alertController.alertBackgroundColor = .white
                                alertController.setAllButtonBackgroundColors(to: UIColor.rgb(hexcolor: "#387ef5"))

                                let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in

                                    self.navigationController?.popViewController(animated: true)
                                    self.containerController?.tabBar.selectedItem = self.containerController?.tabBar.items![0]
                                    self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[4])
                                    self.revealViewController().pushFrontViewController(self.containerController,animated:true)

                                }
                                alertController.addAction(okAction)

                                self.present(alertController, animated: true, completion: nil)
                            }
                        }else{
                            self.showAlert(title: "Failed", message: "Image Uploaded Failed")
                        }
                        
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.hideActivityIndicator()
                        }
                        print("Request failed with error: \(error)")
                    }
                    
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgSelected.image = image

        }else{
            
        }

        self.dismiss(animated: true, completion: nil)
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
