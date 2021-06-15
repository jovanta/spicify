//
//  maincameraViewController.swift
//  Spicify
//
//  Created by Jonathan Herbert on 08/06/21.
//

import AVFoundation
import UIKit
import CoreML

class maincameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    let model = SpiceRecognition_()
    
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    //@IBOutlet weak var shutterButton: UIButton!
    @IBOutlet var bottomView: UIView!
    @IBOutlet weak var snaptipsBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    
    

    var prediction = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(bottomView)
        view.addSubview(snaptipsBtn)
        view.addSubview(libraryBtn)
        view.addSubview(shutterButton)
        self.navigationController?.isNavigationBarHidden = true
        checkCameraPermission()
        
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
       shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
        snaptipsBtn.center = CGPoint(x: view.frame.size.width*0.8, y: view.frame.size.height - 100)
        libraryBtn.center = CGPoint(x: view.frame.size.width*0.2, y: view.frame.size.height - 100)
    }

    func checkCameraPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    return
                }
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCamera()
            break
        @unknown default:
            break
        }
    }
    
    func setupCamera(){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
                
            }
            catch{
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "informationSegue") {
            let vc = segue.destination as! InformationViewController
                vc.prediction = prediction
            vc.flagfromScan = true
            
     }
        
        /*if (segue.identifier == "AlertVC") {
            let vc = segue.destination as! maincameraViewController
            vc.prediction = prediction
            }*/
        
    }
    
    @objc private func didTapTakePhoto(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        
        let image = UIImage(data: data)?.cgImage
        let pixel = getCVPixelBuffer(image!)
        let predict = try? model.prediction(image: pixel!)
        prediction = predict!.classLabel
        print(predict!.classLabel)
        
        performSegue(withIdentifier: "informationSegue", sender: UIButton.self)
    }
    

    func getCVPixelBuffer(_ image: CGImage) -> CVPixelBuffer? {
            let imageWidth = Int(image.width)
            let imageHeight = Int(image.height)
            let attributes : [NSObject:AnyObject] = [
                kCVPixelBufferCGImageCompatibilityKey : true as AnyObject,
                kCVPixelBufferCGBitmapContextCompatibilityKey : true as AnyObject
            ]
            var pxbuffer: CVPixelBuffer? = nil
            CVPixelBufferCreate(kCFAllocatorDefault,
                                imageWidth,
                                imageHeight,
                                kCVPixelFormatType_32ARGB,
                                attributes as CFDictionary?,
                                &pxbuffer)
            if let _pxbuffer = pxbuffer {
                let flags = CVPixelBufferLockFlags(rawValue: 0)
                CVPixelBufferLockBaseAddress(_pxbuffer, flags)
                let pxdata = CVPixelBufferGetBaseAddress(_pxbuffer)
                let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
                let context = CGContext(data: pxdata,
                                        width: imageWidth,
                                        height: imageHeight,
                                        bitsPerComponent: 8,
                                        bytesPerRow: CVPixelBufferGetBytesPerRow(_pxbuffer),
                                        space: rgbColorSpace,
                                        bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
                if let _context = context {
                    _context.draw(image, in: CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight))
                }
                else {
                    CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
                    return nil
                }
                CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
                return _pxbuffer;
            }
            return nil
        }
    
    
    
  
    
    @IBAction func snaptipsBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "AlertVC", sender: self)
        
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
