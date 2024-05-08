//
//  DiplomaEstimatingPresenter.swift
//  App1C
//
//  Created by Станислава on 08.05.2024.
//

import Foundation

final class DiplomaEstimatingPresenter {
    weak var viewInput: DiplomaEstimatingViewInput?
        
    private let diplomasSpeechesService: DiplomaSpeechesServiceProtocol
    private var bachelor: Bool = true
    private var type: GradeType = .autumn
    
    init(
        diplomasSpeechesService: DiplomaSpeechesServiceProtocol
    ) {
        self.diplomasSpeechesService = diplomasSpeechesService
    }
    
    private func getStudents() {
        diplomasSpeechesService.getGrades(type: type.rawValue, bachelor: bachelor) { [weak self] result in
            switch result {
            case .success(let model):
                let students = model.students.map({
                    EstimationModel(studentID: $0.studentID, gradeID: $0.gradeID, name: $0.fullName, grade: GradeModel(grade: $0.result ?? 0))
                })
                DispatchQueue.main.async {
                    self?.viewInput?.setupStudents(students: students)
                }
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed load grades: \(failure)")
            }
        }
    }
    
    private func setGrade(studentID: Int, gradeID: Int, grade: Int) {
        diplomasSpeechesService.estimate(studentID: studentID, gradeID: gradeID, result: grade) { result in
            switch result {
            case .success(_):
                Logger.shared.printLog(log: "Success add grade")
            case .failure(let failure):
                Logger.shared.printLog(log: "Failed add grade: \(failure)")
            }
        }
    }
}

extension DiplomaEstimatingPresenter: DiplomaEstimatingViewOutput {
    func selectDegree(bachelor: Bool) {
        self.bachelor = bachelor
        getStudents()
    }
    
    func selectGrade(type: GradeType) {
        self.type = type
        getStudents()
    }
    
    func estimate(studentID: Int, gradeID: Int, grade: Int) {
        setGrade(studentID: studentID, gradeID: gradeID, grade: grade)
    }
}
