//
//  FilterVC.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import UIKit

class FilterVC: UIViewController {
    
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var toDate: UIButton!
    @IBOutlet weak var searchInBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    
    @IBOutlet weak var dateFromLbl: UILabel!
    @IBOutlet weak var dateToLbl: UILabel!
    
    var isSelecteDateFrom: Bool?
    let viewModel = SearchVM()
    var searchProtocol: FilterSearchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.datePickerView.isHidden = true
    }
    
    func setupViews() {
        DispatchQueue.main.async {
            self.datePicker?.date = Date()
            self.datePicker?.locale = .current
            self.datePicker?.preferredDatePickerStyle = .compact
            self.datePicker?.datePickerMode = .date
            self.searchInBtn.setTitle(self.viewModel.getTitleForSearch(), for: .normal)
        }
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func updateDateResult(_ sender: Any) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateString = datePicker.date.iso8601withFractionalSeconds   //  "2019-02-06T00:35:01.746Z"

  
//        let strDate = timeFormatter.string(from: datePicker.date)
        
        if let selectedDate = isSelecteDateFrom {
            if selectedDate {
                self.dateFromLbl.text = dateString
                self.viewModel.setSelectDateFrom(with: dateString)
            } else {
                self.dateToLbl.text = dateString
                self.viewModel.setSelectDateTo(with: dateString)
            }
        }
        self.dismiss(animated: true, completion: nil)
        self.datePickerView.isHidden = true
    }
    
    @IBAction func searchInAction(_ sender: Any) {
        performSegue(withIdentifier: R.segue.filterVC.searchInSegue, sender: self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectDateFrom(_ sender: Any) {
        isSelecteDateFrom = true
        datePickerView.isHidden = !datePickerView.isHidden
    }
    
    @IBAction func selectDateTo(_ sender: Any) {
        isSelecteDateFrom = false
        datePickerView.isHidden = !datePickerView.isHidden
    }
    
    @IBAction func applyFilterForSearch(_ sender: Any) {
        searchProtocol?.searchByFilters(with: viewModel.getSelectDateFrom(),
                                        with: viewModel.getSelectDateTo())
        self.navigationController?.popViewController(animated: true)
    }
    
}
