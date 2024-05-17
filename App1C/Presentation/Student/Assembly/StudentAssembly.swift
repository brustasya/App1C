//
//  StudentAssembly.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import UIKit

final class StudentAssembly: BaseAssembly {

    override init(serviceAssembly: ServiceAssembly) {
        super.init(serviceAssembly: serviceAssembly)
    }
    
    func makeSettingsModule(moduleOutput: StudentSettingsModuleOutput) -> UIViewController {
        let presenter = StudentSettingsPresenter(moduleOutput: moduleOutput)
        let vc = StudentSettingsViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeMainScreenModule(moduleOutput: StudentMainScreenModuleOutput) -> UIViewController {
        let presenter = StudentMainScreenPresenter(
            moduleOutput: moduleOutput,
            mainScreenService: serviceAssembly.makeMainPageService()
        )
        let vc = StudentMainScreenController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeDiplomaModule() -> UIViewController {
        let presenter = StudentDiplomaPresenter(
            diplomasInfoService: serviceAssembly.makeDiplomasInfoService(), 
            diplomasSpeechesService: serviceAssembly.makeDiplomaSpeechesService()
        )
        let vc = StudentDiplomaViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeEventModule(id: Int, moduleOutput: StudentEventModuleOutput) -> UIViewController {
        let presenter = StudentEventPresenter(
            id: id,
            moduleOutput: moduleOutput,
            eventsService: serviceAssembly.makeEventsService()
        )
        let vc = EventViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeThemeSelectionEventModule(id: Int) -> UIViewController {
        let presenter = ThemeSelectionEventPresenter(
            id: id,
            eventsService: serviceAssembly.makeEventsService()
        )
        let vc = ThemeSelectionEventViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeDiplomaSpeechEventModule(id: Int) -> UIViewController {
        let presenter = DiplomaSpeechEventPresenter(
            id: id,
            eventsService: serviceAssembly.makeEventsService()
        )
        let vc = DiplomaSpeechEventViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCourseSelectionModule(moduleOutput: CourseSelectionModuleOutput) -> UIViewController {
        let presenter = CourseSelectionPresenter(
            courseSelectionService: serviceAssembly.makeCourseSelectionService()
        )
        let vc = CourseSelectionViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeFinalCourseSelectionModule(moduleOutput: FinalCourseSelectionModuleOutput) -> UIViewController {
        let presenter = FinalCourseSelectionPresenter(
            moduleOutput: moduleOutput,
            courseSelectionService: serviceAssembly.makeCourseSelectionService()
        )
        let vc = FinalCourseSelectionViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeCoursesListModule(moduleOutput: StudentCoursesListModuleOutput) -> UIViewController {
        let presenter = StudentCoursesListPresenter(
            moduleOutput: moduleOutput,
            gradesService: serviceAssembly.makeGradesService()
        )
        let vc = StudentCoursesListViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
    func makeTimeTableModule() -> UIViewController {
        let presenter = TimeTablePresenter(
            timeTableService: serviceAssembly.makeTimeTableService()
        )
        let vc = TimeTableViewController(output: presenter)
        presenter.viewInput = vc
        return vc
    }
    
}
