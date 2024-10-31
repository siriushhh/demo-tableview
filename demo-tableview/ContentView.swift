//
//  ContentView.swift
//  demo-tableview
//
//  Created by hxy on 2024/10/31.
//
import UIKit
import SnapKit

// 定义一个模型来存储每个单元格的文本和图像
struct CellData {
    let title: String
    let imageName: String
}

class MyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    
    // 创建包含不同文本和图像名称的数组
    let data: [CellData] = [
        CellData(title: "Apple", imageName: "apple"),
        CellData(title: "Banana", imageName: "banana"),
        CellData(title: "Cherry", imageName: "cherry"),
        CellData(title: "Pear", imageName: "pear"),
        CellData(title: "Blueberry", imageName: "blueberry"),
        CellData(title: "Peach", imageName: "peach"),
        CellData(title: "Grape", imageName: "grape"),
        CellData(title: "Mango", imageName: "mango"),
        CellData(title: "Kiwi", imageName: "kiwi"),
        CellData(title: "Lemon", imageName: "lemon")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 UITableView 的数据源和委托
        tableView.dataSource = self
        tableView.delegate = self
        
        // 注册 UITableViewCell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 添加 UITableView 到视图中
        view.addSubview(tableView)

        // 使用 SnapKit 设置 Auto Layout 约束
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // 设置文本
        let cellData = data[indexPath.row]
        cell.textLabel?.text = cellData.title
        
        // 设置图像
        cell.imageView?.image = UIImage(named: cellData.imageName)

        // 使图像显示正确的大小
        cell.imageView?.contentMode = .scaleAspectFit

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(data[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//创建包装器，在 SwiftUI 中嵌入 UIKit 控制器，并实现预览功能
import SwiftUI

struct MyTableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyTableViewController {
        return MyTableViewController()
    }

    func updateUIViewController(_ uiViewController: MyTableViewController, context: Context) {
        // 更新控制器时的代码
    }
}

struct ContentView: View {
    var body: some View {
        MyTableViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all) // 如果需要，忽略安全区域
    }
}

#Preview {
    ContentView()
}
