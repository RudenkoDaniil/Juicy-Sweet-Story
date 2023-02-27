//
//  PuzzleViewController.swift
//  Juicy Sweet Story
//
//  Created by Даниил on 24.02.2023.
//

import UIKit

class MyBlock : UIImageView {
    var originalCenter: CGPoint!
}

class PuzzleViewController: UIViewController {
    //MARK: - properties
    public var progress: Int = 1
    private var currentString = ""
    public var completion: (() -> (Void))?
    public var gameImage : UIImage!
    
    private let array = [#imageLiteral(resourceName: "lvl1"), #imageLiteral(resourceName: "lvl7"), #imageLiteral(resourceName: "lvl6"), #imageLiteral(resourceName: "lvl3"), #imageLiteral(resourceName: "lvl5"), #imageLiteral(resourceName: "lvl11"), #imageLiteral(resourceName: "lvl12"), #imageLiteral(resourceName: "lvl4"), #imageLiteral(resourceName: "lvl8"), #imageLiteral(resourceName: "lvl2"), #imageLiteral(resourceName: "lvl10"), #imageLiteral(resourceName: "lvl5"), ]
    /// game properties
    private var timer = Timer()
    private var empty: CGPoint!
    private  var gameOver : Bool = false
    private var gameViewWidth : CGFloat!
    private var blockWidth : CGFloat!
    private var visibleBlocks : Int!
    private var rowSize : Int! = 4
    private var blockArray: NSMutableArray = []
    private var centersArray: NSMutableArray = []
    private var finalBlock : MyBlock!
    private var xCenter : CGFloat!
    private var yCenter : CGFloat!
    private var images: [UIImage] = []
    
    private var seconds = 190
    
    
    // MARK: - UIViews
    private var imagePreview = UIImageView()
    private var gameView = UIView()
    private var timerLabel = SystemLabbel()
    private var lvlLabel = SystemLabbel()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "Vector (1)").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        button.backgroundColor = .white
        button.layer.cornerRadius = 50/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "reload").withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.tintColor = .purple1
        button.imageView?.layer.transform = CATransform3DMakeScale(0.6, 0.6, 0.6)
        button.backgroundColor = .white
        button.layer.cornerRadius = 50/2
        button.layer.borderColor = UIColor.purple1.cgColor
        button.layer.borderWidth = 3
        button.addTarget(self, action: #selector(ResetButton), for: .touchUpInside)
        return button
    }()
    private let ImageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "background")
        return iv
    }()
    
    // MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewsAutoLayout()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myTouch : UITouch = touches.first!
        if (blockArray.contains(myTouch.view as Any)){
            
            let touchView: MyBlock = (myTouch.view)! as! MyBlock
            
            let xOffset: CGFloat = touchView.center.x - empty.x
            let yOffset: CGFloat = touchView.center.y - empty.y
            
            let distanceBetweenCenters : CGFloat = sqrt(pow(xOffset, 2) + pow(yOffset, 2))
            
            if (Int(distanceBetweenCenters) == Int(blockWidth)) {
                let temporaryCenter : CGPoint = touchView.center
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                touchView.center = empty
                UIView.commitAnimations()
                
                //self.clickAction()
                empty = temporaryCenter
                checkBlocks()
                
                if gameOver == true {
                    setUserInteractionStateForAllBlocks(state: false)
                    displayFinalBlock()
                    displayGameOverAlert(result: true)
                }
            }
        }
    }
    
    // MARK: - handlers
    private func configureView(){
        gameView.backgroundColor = .white
        view.addSubview(ImageView)
        view.sendSubviewToBack(ImageView)
        view.addSubview(imagePreview)
        view.addSubview(timerLabel)
        view.addSubview(gameView)
        view.addSubview(backButton)
        view.addSubview(lvlLabel)
        view.addSubview(reloadButton)
        
        seconds = seconds - 10 * progress
        lvlLabel.textToSet = " LVL-\(progress) "
        makeBlocks()
        scramble()
        finalBlock.removeFromSuperview()
        gameOver = false
        setUserInteractionStateForAllBlocks(state: true)
        imagePreview.image = gameImage
        
        let corner2 = UIImageView(image: #imageLiteral(resourceName: "candy frame"))
        view.addSubview(corner2)
        corner2.anchor(top: imagePreview.topAnchor, left: imagePreview.leftAnchor, bottom: imagePreview.bottomAnchor, right: imagePreview.rightAnchor, paddingTop: -5, paddingLeft: -5, paddingBottom: -5, paddingRight: -5, width: 0, height: 0)
        let corner = UIImageView(image: #imageLiteral(resourceName: "candy frame"))
        view.addSubview(corner)
        corner.anchor(top: gameView.topAnchor, left: gameView.leftAnchor, bottom: gameView.bottomAnchor, right: gameView.rightAnchor, paddingTop: -15, paddingLeft: -15, paddingBottom: -15, paddingRight: -15, width: 0, height: 0)
        
        let borderPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 300, height: 300), cornerRadius: 25)
        let maskLayer = CAShapeLayer()
        maskLayer.path = borderPath.cgPath
        maskLayer.frame = gameView.bounds
        maskLayer.backgroundColor = UIColor.red.cgColor
        gameView.layer.mask = maskLayer
    }
    private func viewsAutoLayout() {
        timerLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 120, height: 50)
        lvlLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: timerLabel.leftAnchor, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 120, height: 50)
        
        gameView.anchor(top: timerLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 300)
        gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imagePreview.anchor(top: gameView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 170, height: 170)
        imagePreview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        reloadButton.anchor(top: view.topAnchor, left: backButton.rightAnchor, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    // MARK: - Game handlers
    private func scramble() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        let temporaryCentersArray: NSMutableArray = centersArray.mutableCopy() as! NSMutableArray
        for anyBlock in blockArray {
            let randomIndex: Int = Int(arc4random()) % temporaryCentersArray.count
            let randomCenter: CGPoint = temporaryCentersArray[randomIndex] as! CGPoint
            (anyBlock as! MyBlock).center = randomCenter
            temporaryCentersArray.removeObject(at: randomIndex)
        }
        empty = (temporaryCentersArray[0] as! CGPoint)
    }
    
    private func setUserInteractionStateForAllBlocks(state: Bool) {
        for i in 0..<visibleBlocks {
            (blockArray[i] as! MyBlock).isUserInteractionEnabled = state
        }
    }
    private func makeBlocks() {
        blockArray = []
        centersArray = []
        visibleBlocks = (rowSize * rowSize) - 1
        
        gameViewWidth = 300
        blockWidth = gameViewWidth / CGFloat(rowSize)
        
        xCenter = blockWidth / 2
        yCenter = blockWidth / 2
        
        images = slice(image: gameImage, into:rowSize)
        var picNum = 0
        
        for _ in 0..<rowSize {
            for _ in 0..<rowSize {
                let blockFrame : CGRect = CGRect(x: 0, y: 0, width: blockWidth, height: blockWidth)
                let block: MyBlock = MyBlock (frame: blockFrame)
                let thisCenter : CGPoint = CGPoint(x: xCenter, y: yCenter)
                
                block.isUserInteractionEnabled = true
                block.image = images[picNum]
                picNum += 1
                
                block.center = thisCenter
                block.originalCenter = thisCenter
                gameView.addSubview(block)
                blockArray.add(block)
                
                xCenter = xCenter + blockWidth
                centersArray.add(thisCenter)
            }
            xCenter = blockWidth / 2
            yCenter = yCenter + blockWidth
        }
        
        finalBlock = (blockArray[visibleBlocks] as! MyBlock)
        finalBlock.removeFromSuperview()
        blockArray.removeObject(identicalTo: finalBlock as Any)
    }
    private func slice(image: UIImage, into howMany: Int) -> [UIImage] {
        let width: CGFloat = image.size.width
        let height: CGFloat = image.size.height
        let tileWidth = Int(width / CGFloat(howMany))
        let tileHeight = Int(height / CGFloat(howMany))
        let scale = Int(image.scale)
        var imageSections = [UIImage]()
        let cgImage = image.cgImage!
        var adjustedHeight = tileHeight
        
        var y = 0
        for row in 0 ..< howMany {
            if row == (howMany - 1) {
                adjustedHeight = Int(height) - y
            }
            var adjustedWidth = tileWidth
            var x = 0
            for column in 0 ..< howMany {
                if column == (howMany - 1) {
                    adjustedWidth = Int(width) - x
                }
                let origin = CGPoint(x: x * scale, y: y * scale)
                let size = CGSize(width: adjustedWidth * scale, height: adjustedHeight * scale)
                let tileCgImage = cgImage.cropping(to: CGRect(origin: origin, size: size))!
                imageSections.append(UIImage(cgImage: tileCgImage, scale: image.scale, orientation: image.imageOrientation))
                x += tileWidth
            }
            y += tileHeight
        }
        return imageSections
    }
    
    private func displayFinalBlock() { gameView.addSubview(finalBlock) }
    
    private func displayGameOverAlert(result: Bool) {
        timer.invalidate()
        let vc = EndLVLViewController()
        vc.progress = progress
        vc.result = result
        if result == true {
            let (minutes, remainingSeconds) = convertSecondsToMinutesAndSeconds(seconds: self.seconds)
            let timeString = String(format: "%02d:%02d", minutes, remainingSeconds)
            vc.timerLabel.textToSet = " \(timeString) "
            let bestTime = UserDefaults.standard.value(forKey: "lvlResult\(progress)") as? Int ?? 1
            if bestTime < seconds {
                UserDefaults.standard.set(seconds, forKey: "lvlResult\(progress)")
            }
        }
        vc.completion = { [self] result in
            if result == 0 { dismiss(animated: true, completion: { [weak self] in
                self?.completion?()
            })}
            else if result == 1 { ResetButton() }
            else {
                progress = progress+1
                UIView.transition(with: imagePreview, duration: 0.5, options: .transitionCrossDissolve, animations: { [self] in
                    imagePreview.image = array[progress]
                    gameImage = array[progress]
                    
                    seconds = 190 - 10 * progress
                    lvlLabel.textToSet = " LVL-\(progress) "
                    makeBlocks()
                    scramble()
                    finalBlock.removeFromSuperview()
                    gameOver = false
                    setUserInteractionStateForAllBlocks(state: true)
                }, completion: { _ in
                    
                })
            }
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    private func checkBlocks() {
        var correctBlockCounter = 0
        for i in 0..<visibleBlocks {
            if (blockArray[i] as! MyBlock).center == (blockArray[i] as! MyBlock).originalCenter {
                correctBlockCounter += 1
            }
        }
        if correctBlockCounter == visibleBlocks {
            gameOver = true
            if progress != 12 { UserDefaults.standard.set(progress+1, forKey: "userProgress") }
        }
        else { gameOver = false }
    }
    // MARK: - @objc
    @objc func ResetButton() {
        timer.invalidate()
        seconds = 190-10*progress
        finalBlock.removeFromSuperview()
        gameOver = false
        setUserInteractionStateForAllBlocks(state: true)
        scramble()
    }
    @objc func updateTimer() {
        if seconds > 0 {
            seconds -= 1
            UIView.transition(with: timerLabel, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                let (minutes, remainingSeconds) = convertSecondsToMinutesAndSeconds(seconds: self.seconds)
                let timeString = String(format: "%02d:%02d", minutes, remainingSeconds)
                self.timerLabel.textToSet = " \(timeString) "
            }, completion: nil)
            
        } else {
            timer.invalidate()
            UIView.transition(with: timerLabel, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                self.timerLabel.textToSet = " Time's up! "
            }, completion: nil)
            
            displayGameOverAlert(result: false)
        }
    }
    @objc func dismiss(_ sender: UIButton){
        dismiss(animated: true, completion: { [weak self] in
            self?.completion?()
        })
    }
    /// handler to test how game works
    @objc func showSolutionTapped() {
        if (gameOver == false) {
            let tempCentersArray : NSMutableArray = []
            (self.finalBlock).center = self.empty
            
            for i in 0..<visibleBlocks {
                tempCentersArray.add((blockArray[i] as! MyBlock).center)
            }
            
            UIView.animate(withDuration: 1, animations: {
                for i in 0..<self.visibleBlocks {
                    (self.self.blockArray[i] as! MyBlock).center = (self.blockArray[i] as! MyBlock).originalCenter
                }
                //self.gameView.addSubview(self.finalBlock)
                (self.finalBlock).center = (self.finalBlock).originalCenter
            })
        }
    }
}
