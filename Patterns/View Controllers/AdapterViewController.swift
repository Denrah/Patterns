//
//  AdapterViewController.swift
//  Patterns
//
//  Created by National Team on 28.10.2021.
//

import UIKit

protocol MeasurmentsDataStore {
  func getAllMeshuarments() -> [Int]
  func getMeashurmentsCount() -> Int
  func getMaxMeasurment() -> Int
  func gerMinMeasurment() -> Int
}

class StubDataStore: MeasurmentsDataStore {
  private let measurments = [3, 12, 4, 10, 2, 5, 18, 7]
  
  func getAllMeshuarments() -> [Int] {
    return measurments
  }
  
  func getMeashurmentsCount() -> Int {
    return measurments.count
  }
  
  func getMaxMeasurment() -> Int {
    return measurments.max() ?? 0
  }
  
  func gerMinMeasurment() -> Int {
    return measurments.min() ?? 0
  }
}

protocol ChartDataSource {
  func chartValues() -> [Double]
  func maxValue() -> Double
  func valuesCount() -> Int
}

class ChartView: UIStackView {
  var dataSource: ChartDataSource? {
    didSet {
      drawData()
    }
  }
  
  func drawData() {
    guard let dataSource = dataSource else { return }
    
    arrangedSubviews.forEach { $0.removeFromSuperview() }
    spacing = 8
    axis = .vertical
    alignment = .leading
    
    let values = dataSource.chartValues()
    let maxValue = dataSource.maxValue()
    
    for index in 0..<dataSource.valuesCount() {
      let value = values[index]
      let rowView = UIView()
      addArrangedSubview(rowView)
      
      rowView.backgroundColor = .systemGreen
      rowView.layer.cornerRadius = 4
      rowView.snp.makeConstraints { make in
        make.height.equalTo(32)
        make.width.equalToSuperview().multipliedBy(value / maxValue)
      }
      
      let label = UILabel()
      label.textColor = .white
      label.text = "\(index + 1)"
      rowView.addSubview(label)
      label.snp.makeConstraints { make in
        make.leading.equalToSuperview().inset(16)
        make.centerY.equalToSuperview()
      }
    }
  }
}

class MeasurmentsDataStoreToChartDataSourceAdapter: ChartDataSource {
  private let dataStore: MeasurmentsDataStore
  
  init(dataStore: MeasurmentsDataStore) {
    self.dataStore = dataStore
  }
  
  func chartValues() -> [Double] {
    return dataStore.getAllMeshuarments().map { Double($0) }
  }
  
  func maxValue() -> Double {
    return Double(dataStore.getMaxMeasurment())
  }
  
  func valuesCount() -> Int {
    return dataStore.getMeashurmentsCount()
  }
}

class AdapterViewController: UIViewController {
  
  private let dataSource: MeasurmentsDataStore = StubDataStore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let chartView = ChartView()
    view.addSubview(chartView)
    chartView.snp.makeConstraints { make in
      make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
    }
    
    let adapter = MeasurmentsDataStoreToChartDataSourceAdapter(dataStore: dataSource)
    chartView.dataSource = adapter
    
    // Do any additional setup after loading the view.
  }
}
