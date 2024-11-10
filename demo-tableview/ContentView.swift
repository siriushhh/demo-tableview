import SwiftUI
import UIKit
import SnapKit

struct CellData {
    let title: String
    let imageName: String
    let description: String // 添加多行描述属性
}

class DetailViewController: UIViewController {
    var item: CellData?
    
    private let imageView = UIImageView() //创建UIImageView
    private let favoriteSwitch = UISwitch() // 改为收藏开关
    private let favoriteLabel = UILabel() // 显示收藏状态的标签
    private let descriptionLabel = UILabel() // 多行描述标签
    private let timePicker = UIDatePicker() // 添加时间选择器
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 自定义返回按钮
            let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        
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
                    make.top.equalTo(imageView.snp.top).offset(-90) // 图片上方 90 点
                    make.centerX.equalToSuperview() // 水平居中
                }
        
        // 设置多行描述标签
                descriptionLabel.text = item?.description
                descriptionLabel.numberOfLines = 0 // 允许多行
                descriptionLabel.textAlignment = .center
                descriptionLabel.font = UIFont.italicSystemFont(ofSize: 16) // 设置斜体字体
                descriptionLabel.textColor = .red // 设置字体颜色为红色
                view.addSubview(descriptionLabel)

        // 设置描述标签的约束
                descriptionLabel.snp.makeConstraints { make in
                    make.top.equalTo(label.snp.bottom).offset(20)
                    make.leading.equalTo(view).offset(20)
                    make.trailing.equalTo(view).offset(-20)
                }
        
        // 设置收藏开关和状态标签
                favoriteLabel.text = "Add to Favorites"
                favoriteLabel.textColor = .systemBlue
                view.addSubview(favoriteLabel)
                
                favoriteSwitch.addTarget(self, action: #selector(favoriteSwitchToggled), for: .valueChanged)
                view.addSubview(favoriteSwitch)
                
                favoriteLabel.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                    make.right.equalToSuperview().offset(-75) // 右对齐并向左偏移75点
                    //make.leading.equalTo(view).offset(20)
                }
        
                favoriteSwitch.snp.makeConstraints { make in
                    make.centerY.equalTo(favoriteLabel)
                    make.leading.equalTo(favoriteLabel.snp.trailing).offset(10)
                }
        
        // 设置时间选择器
                timePicker.datePickerMode = .time // 设置选择模式为时分秒
                timePicker.locale = Locale(identifier: "en_US_POSIX") // 使用 24 小时制
                timePicker.preferredDatePickerStyle = .wheels // 使用滚轮样式
                view.addSubview(timePicker)
                
                timePicker.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.top).offset(200) // 图片上方 90 点
                    make.leading.equalTo(view).offset(20)
                    make.trailing.equalTo(view).offset(-20)
                }
  
        navigationItem.title = "Detail"  // 使用系统默认的返回按钮
    }
    
    
    @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
    
    @objc private func favoriteSwitchToggled() {
            if favoriteSwitch.isOn {
                print("\(item?.title ?? "Item") added to favorites!")
                favoriteLabel.text = "Favorited!"
            } else {
                print("\(item?.title ?? "Item") removed from favorites!")
                favoriteLabel.text = "Add to Favorites"
            }
        }
   /* @objc private func favoriteButtonTapped() {
            // 收藏功能的逻辑，可以将水果添加到收藏列表
            print("\(item?.title ?? "Item") added to favorites!")
            favoriteButton.setTitle("Favorited!", for: .normal)
            favoriteButton.isEnabled = false // 禁用按钮以避免重复收藏
        }*/
}

class MyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    let data: [CellData] = [
        CellData(title: "Apple", imageName: "apple", description: "A juicy red apple that's very healthy."),
        CellData(title: "Banana", imageName: "banana", description: "A sweet yellow banana, great for snacks."),
        CellData(title: "Cherry", imageName: "cherry", description: "A bunch of red cherries, small and tasty."),
        CellData(title: "Pear", imageName: "pear", description: "A green pear with a soft and juicy texture."),
        CellData(title: "Blueberry", imageName: "blueberry", description: "Small blue berries packed with antioxidants."),
        CellData(title: "Peach", imageName: "peach", description: "A soft peach with a sweet and fuzzy exterior."),
        CellData(title: "Grape", imageName: "grape", description: "Bunches of purple grapes, great for snacking."),
        CellData(title: "Mango", imageName: "mango", description: "A tropical mango with a sweet, juicy flavor."),
        CellData(title: "Kiwi", imageName: "kiwi", description: "A small green fruit with a unique tart flavor."),
        CellData(title: "Lemon", imageName: "lemon", description: "A sour lemon perfect for adding flavor.")
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

