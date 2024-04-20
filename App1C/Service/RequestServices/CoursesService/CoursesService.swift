//
//  CoursesService.swift
//  App1C
//
//  Created by Станислава on 19.04.2024.
//

import Foundation

protocol CoursesServiceProtocol {
    func getCourseDetailes(courseID: Int, completion: @escaping (Result<CourseDetailsModel, Error>) -> Void)
    func getCourses(completion: @escaping (Result<CoursesModel, Error>) -> Void)
    func getDeps(courseID: Int, completion: @escaping (Result<CoursesModel, Error>) -> Void)
    func changeDeps(courseID: Int, deps: [Int], completion: @escaping (Result<Data?, Error>) -> Void)
    func createCourse(model: CreateCourseModel, completion: @escaping (Result<Data?, Error>) -> Void)
    func getTeacherCourses(teacherID: Int, completion: @escaping (Result<CoursesModel, Error>) -> Void)
}

class CoursesService: CoursesServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let requestFactory: CoursesURLRequestFactory
    
    init(networkService: NetworkServiceProtocol,
         requestFactory: CoursesURLRequestFactory) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func getCourseDetailes(courseID: Int, completion: @escaping (Result<CourseDetailsModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getCourseDetails(for: courseID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getCourses(completion: @escaping (Result<CoursesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getCourses()
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getDeps(courseID: Int, completion: @escaping (Result<CoursesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getDeps(courseID: courseID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createCourse(model: CreateCourseModel, completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.createCourse(with: model)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func changeDeps(courseID: Int, deps: [Int], completion: @escaping (Result<Data?, Error>) -> Void) {
        do {
            let request = try requestFactory.changeDeps(courseID: courseID, deps: deps)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func getTeacherCourses(teacherID: Int, completion: @escaping (Result<CoursesModel, Error>) -> Void) {
        do {
            let request = try requestFactory.getTeacherCourses(for: teacherID)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
