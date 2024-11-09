import SwiftUI
import UIKit
import SnapKit

struct CellData {
    let title: String
    let imageName: String
}

class DetailViewController: UIViewController {
    var item: CellData?
    
    private let imageView = UIImageView() // 创建 UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置图片
                if let imageName = item?.imageName {
                    imageView.image = UIImage(named: imageName)
                }
                imageView.contentMode = .scaleAspectFit // 设置内容模式以适应图像
                view.addSubview(imageView)

        
        // 使用 SnapKit 设置约束
                imageView.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(200) // 距离顶部 200 点
                    make.centerX.equalToSuperview() // 水平居中
                    make.height.equalTo(200) // 设置高度
                    make.width.equalTo(200) // 设置宽度
                }
        
        
        let label = UILabel()
        label.text = item?.title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)

        // 使用 SnapKit 设置标签的约束
                label.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.top).offset(-50) // 图片上方 50 点
                    make.centerX.equalToSuperview() // 水平居中
                }

        navigationItem.title = "Detail"
        // 使用系统默认的返回按钮
    }
    @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
}

class MyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
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

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        navigationItem.title = "Fruits"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = data[indexPath.row]
        cell.textLabel?.text = cellData.title
        cell.imageView?.image = UIImage(named: cellData.imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.item = data[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

struct MyTableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyTableViewController {
        return MyTableViewController()
    }

    func updateUIViewController(_ uiViewController: MyTableViewController, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        MyTableViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}



@main
struct demo_tableviewApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MyTableViewControllerRepresentable()
            }
        }
    }
}


#Preview {
    ContentView()
}
