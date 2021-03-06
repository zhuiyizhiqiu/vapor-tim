import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post("api", "acronyms") { req -> Future<Acronym> in
        return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { acronym in
            return acronym.save(on: req)
        }
    }
    router.get("hello",String.parameter) { (req) -> String in
        let name = try req.parameters.next(String.self)
        
        return "Hello,\(name)!"
    }
    
    router.post(InfoData.self,at: "info") { (req,data) in
        return "Hello \(data.name)!"
    }

    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
    let name: String
}
