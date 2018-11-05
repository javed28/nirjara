//
//  ImageUploadCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 3/11/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import JHTAlertController
import YPImagePicker
import IQKeyboardManagerSwift
class ImageUploadCntr: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var txtAddLocation: UITextField!
    @IBOutlet weak var txtCaption: UITextView!
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnUploadphoto: UIButton!
    var imageName = String()
    @IBOutlet weak var imgSelected: UIImageView!
    var pickerController = UIImagePickerController()
    
    @IBOutlet weak var lblAddCaption: UILabel!
    
        var containerController: ContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Image Upload"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:8))
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.orangeColor), range: NSRange(location:8,length:6))
        titleLabel.attributedText = myMutableString
        navigationItem.titleView = titleLabel
        
        self.updateBackButton()
        
        //txtAddLocation.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:50)
        txtAddLocation.alpha = 0
       /* lblAddCaption.frame = CGRect(x:10,y:10,width:self.view.frame.width-20,height:25)
        txtCaption.frame = CGRect(x:10,y:38,width:self.view.frame.width-20,height:120)
        //imgSelected.frame = CGRect(x:0,y:txtCaption.frame.origin.y+txtCaption.frame.height+10,width:300,height:300)
        
        
        view.addConstraint(NSLayoutConstraint(item: imgSelected, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10))
        
        view.addConstraint(NSLayoutConstraint(item: imgSelected, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: imgSelected, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .top, multiplier: 1, constant: txtCaption.frame.origin.y+txtCaption.frame.height+20))
        
        //view.addConstraint(NSLayoutConstraint(item: imgSelected, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,multiplier: 1, constant: -50))
        

        
        self.view.addSubview(imgSelected)*/
        
        lblAddCaption.text = "AddCaption".localized1
        
        
        btnTakePhoto.frame = CGRect(x:5,y:self.view.frame.height-130,width:self.view.frame.width/2-5,height:60)
        btnUploadphoto.frame = CGRect(x:self.view.frame.width/2+5,y:self.view.frame.height-130,width:self.view.frame.width/2-10,height:60)
        btnTakePhoto.setTitle("TakePhoto".localized1, for: .normal)
        btnUploadphoto.setTitle("Upload".localized1, for: .normal)
        containerController = revealViewController().frontViewController as? ContainerViewController
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
//    @objc func dismissKeyboard() {
//        
//        view.endEditing(true)
//    }

    @IBAction func takeImageClicked(_ sender: Any) {
//        let img = UIImagePickerController()
//        img.delegate = self
//        img.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        img.allowsEditing = false
//        self.present(img,animated: true)

        
        /*
        let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
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
        self.present(alertViewController, animated: true, completion: nil)
 */
        self.imgSelected.image = nil;
        /*let fusuma = FusumaViewController()
        
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = false
        //        fusuma.availableModes = [.video]
        //fusumaSavesImage = true
        
        self.present(fusuma, animated: true, completion: nil)*/
        
        
        var config = YPImagePickerConfiguration()
        config.onlySquareImagesFromLibrary = false
        config.onlySquareImagesFromCamera = true
        config.libraryTargetImageSize = .original
        config.usesFrontCamera = true
        config.showsFilters = false
        //config.shouldSaveNewPicturesToAlbum = true
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
            pickerController.allowsEditing = true
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
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgSelected.image = image
        
            
//            let imageName = UUID().uuidString
//            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//
//            print("imagePath----",imagePath)
//
//            if let jpegData = UIImageJPEGRepresentation(image, 80) {
//                try? jpegData.write(to: imagePath)
//            }
            
        }else{
            
        }
        
//        if let imageURL = info[UIImagePickerControllerReferenceURL] as? URL {
//            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
//            let asset = result.firstObject
//            self.imageName = asset?.value(forKey: "filename")! as! String
//
//            print("file name----",self.imageName)
//
//        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func uploadImg(_ sender: Any) {
        //myImageUploadRequest()
        if(imgSelected.image == nil){
             self.showAlert(title: "Warning", message: "Please Select Some Image First")
        }else{
            if isConnectedToNetwork() {
        uploadImg()
        }else{
            showAlert(title: "OOp's", message: "No Internet Connection")
        }
        }
    }
    
    func uploadImg(){

      self.showActivityIndicator()
        let imgData = UIImageJPEGRepresentation(imgSelected.image!, 0.2)!

        //let encodedString = txtCaption.text!.encodeEmoji
        let data = txtCaption.text?.data(using: String.Encoding.nonLossyASCII)
        let message = String(data : data!,encoding : String.Encoding.utf8)
        let encodedString = message?.replacingOccurrences(of: "\\", with: "\\\\")
        
        
        let parameters = ["member_id": UserDefaults.standard.getUserID(),"title":encodedString!,"location":txtAddLocation.text!]
        print("image from gallery uploading para--\(parameters)")
   
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image", fileName: String(self.randomInt(min: 1,max: 100000))+".png", mimeType: "image/png")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
    to:ServerUrl.post_gallery_image_ios)
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
                                self.containerController?.swapFromViewController(fromViewController: self.containerController!.controller as! UIViewController, toViewController: self.containerController!.controllers[1])
                                self.revealViewController().pushFrontViewController(self.containerController,animated:true)
                                
//                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                                let gotoHome = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//                                self.navigationController?.pushViewController(gotoHome!, animated: true)
                                
                                
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
    
    func myImageUploadRequest()
    {
        let myUrl = URL(string:ServerUrl.post_gallery_image_ios);
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST";
        
        let param = [
            "title"  : UserDefaults.standard.getMemberName(),
            "location"    : UserDefaults.standard.getMemberName(),
            "userId"    : UserDefaults.standard.getUserID()
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        showActivityIndicator()
        
        let imageData = UIImageJPEGRepresentation(imgSelected.image!, 1)
        
        if(imageData==nil)  {
            return;
            
        }
        
       // request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        request.httpBody = self.createRequestBodyWith(parameters:param as [String : NSObject], filePathKey:"file", boundary:self.generateBoundaryString()) as Data
        
       // myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json)
//
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                    self.imgSelected.image = nil;
                    
                }
            }catch
            {
                print(error)
            }
            
        }
        
        task.resume()
    }
    func createRequestBodyWith(parameters:[String:NSObject], filePathKey:String, boundary:String) -> NSData{
        
        let body = NSMutableData()
        
        for (key, value) in parameters {
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        
        body.appendString(string: "--\(boundary)\r\n")
        
        var mimetype = "image/jpg"
        
        let defFileName = "yourImageName.jpg"
        
        let imageData = UIImageJPEGRepresentation(imgSelected.image!, 1)
        
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(defFileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageData!)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
}
}
