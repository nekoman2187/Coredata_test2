//
//  ViewController.swift
//  Coredata_test1
//
//  Created by 渡辺 昭則 on 2018/05/09.
//  Copyright © 2018年 nakoman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managedContext:NSManagedObjectContext!
    override func viewDidLoad() {
        let test = ["watanabe","ishida","tamaki"]
        let test1 = ["inaba","kawakami","yokoi"]
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        let  fetchRequest:NSFetchRequest<Level> = Level.fetchRequest()
        let fetchData = try? managedContext.fetch(fetchRequest)
        if fetchData?.isEmpty == false {
            return
        }
        for i in 1...2 {
            let level = Level(context: managedContext)
            level.level = Int32(i)
            if i == 1 {
                    for j in test {
                        let mem = Member(context:managedContext)
                        mem.name = j
                        mem.age = 56
                        let tmpimge = UIImage(named: "maps-2-icon.png")
                        mem.image = UIImagePNGRepresentation(tmpimge!)!
                       // mem.image = convdata as Data
                  //      mem.image =  #imageLiteral(resourceName: "maps-2-icon") as! Data
                        level.addToLev(mem)
                }
            } else {
                for j in test1 {
                    let mem = Member(context:managedContext)
                    mem.name = j
                    mem.age = 45
                    let tmpimge = UIImage(named: "maps-2-icon.png")
                    mem.image = UIImagePNGRepresentation(tmpimge!)!
                    level.addToLev(mem)

                }
            }
        }
        do {
                    try managedContext.save()
                    } catch {
                        print(error)
            }
    }

    @IBAction func update(_ sender: Any) {
        let fetchRequestMem:NSFetchRequest<Member> = Member.fetchRequest()
        let predicate = NSPredicate(format:"%K = %@","name","watanabe")
        fetchRequestMem.predicate = predicate
        let fetchDataMem = try? managedContext.fetch(fetchRequestMem)
        if fetchDataMem?.isEmpty == false {
            for attr in fetchDataMem! {
                attr.age = 25
                print(attr.age)
            }

        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    @IBAction func Del(_ sender: Any) {
        let fetchRequestMem:NSFetchRequest<Member> = Member.fetchRequest()
        let predicate = NSPredicate(format:"%K = %@","name","kawakami")
        fetchRequestMem.predicate = predicate
        let fetchDataMem = try? managedContext.fetch(fetchRequestMem)
        if fetchDataMem?.isEmpty == false {
            managedContext.delete(fetchDataMem![0])
        }
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    @IBOutlet var ImageView: UIImageView!
    @IBAction func action(_ sender: UIButton) {
        let  fetchRequest:NSFetchRequest<Level> = Level.fetchRequest()
          //   let predicate = NSPredicate(format:"%K = %d","Level",i)
          //  fetchRequest.predicate = predicate
        let fetchData = try? managedContext.fetch(fetchRequest)
        let max = fetchData?.count
        print(max!)
        for i in 0..<max! {
            let obj = fetchData![i] as Level
            print(obj.level)
            for  mem in obj.lev! {
                let val = mem as! Member
                print(mem)
                print(val.age)
                print(val.name)
                
            }
            
            let fetchRequestMem:NSFetchRequest<Member> = Member.fetchRequest()
            let predicate = NSPredicate(format:"%K = %@","name","watanabe")
            fetchRequestMem.predicate = predicate
            let fetchDataMem = try? managedContext.fetch(fetchRequestMem)
            if fetchDataMem?.isEmpty == false {
                let tt = fetchDataMem![0]
                print(tt.age)
                for attr in fetchDataMem! {
                   
                        print(attr.age)
                    if let imagebuff = attr.image {
                        ImageView.image =  UIImage(data: imagebuff)
                    }
                }
           
//                for data in fetchDataMem! {
//                    print(data.age)
//                    print(data.name!)
//                }
            } else {
                print("empty!!")
            }
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

