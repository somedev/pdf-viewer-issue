//
//  ViewController.swift
//  PdfViewer
//
//  Created by AP Eduard Panasiuk on 2/21/20.
//  Copyright © 2020 Ed. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "pdf"),
            let pdf = PDFDocument(url: url)
        else {
            return
        }
        
        pdfView.document = pdf
        
        
        //PDFViewPageChanged - Notification when a new page becomes current.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pageChanged),
                                               name: .PDFViewPageChanged,
                                               object: pdfView)
        
        //PDFViewVisiblePagesChanged - Notification when the scroll view has scrolled into the bounds of a new page.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(visiblePageChanged),
                                               name: .PDFViewVisiblePagesChanged,
                                               object: pdfView)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pdfView.scaleFactor = pdfView.scaleFactorForSizeToFit
    }
    
    @objc func visiblePageChanged(notification:Notification) {
        print("visiblePageChanged: \(notification)")
    }
    
    
    @objc func pageChanged(notification:Notification) {
         print("pageChanged: \(notification)")
    }

    
    
}

