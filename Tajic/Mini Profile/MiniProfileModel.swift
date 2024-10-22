//
//  MiniProfileModel.swift
//  CampusFrance
//
//  Created by UNICA on 26/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class MiniProfileModel: NSObject {
    var firstStep             = StepOneModel()
    
    var thirdStep             = StepThreeModel()
    
    
    var highSchoolDetails     = HighSchoolModel()
    var graduationDetails     = GraduationModel()
    var postGraduationDetails = PostGraduationModel()
    var otherEducationDetails = OtherEudcationModel()
    
    convenience init(with data:[String:Any]) {
     self.init()
        
        //***********************************************//
        // MARK: Step ONE
        //***********************************************//
        if let education_status = data["education_status"] as? String {
            firstStep.isCompleted = education_status
        }
        if let  educationName = data["higher_education_name"] as? String{
          firstStep.highEducationName = educationName
            
        }
        
        if let instName = data["institution_name"] as? String {
            firstStep.instName = instName
        }
        if let highestEducationLevelId = data["highest_education_level_id"] as? String {
            firstStep.highEducationId = Int(highestEducationLevelId)!
        }
        if let countryId = data["last_education_country_id"] as? String{
            firstStep.coutryId  = Int(countryId)!
        }
        
        if let grading_system_id = data["grading_system_id"] as? String{
            firstStep.gradeId    = Int(grading_system_id)!
        }
        if let sub_grading_system_id = data["sub_grading_system_id"] as? String{
            firstStep.subgradeId =  Int(sub_grading_system_id)!
        }
         if let sub_grading_system_Percentage = data["sub_grading_system_percentage"] as? String{
            firstStep.subgradePercentage =  sub_grading_system_Percentage
         }
        if let interestedSubCategoryId = data["interested_category_id_option2"] as? String {
            if interestedSubCategoryId.isEmpty == false {
                if let index = Int(interestedSubCategoryId) {
                  //  secondStep.interestedSubCategoryId = index
                    print(index)
                }
            }
          
        }
       
        /*
        //***********************************************//
        // MARK: Step two
        //***********************************************//
        if let apply_education_level_id = data["apply_education_level_id"] as? String {
         // secondStep.educationLevelId = Int(apply_education_level_id)!
        }
       
        if let apply_course_type_id = data["apply_course_type_id"] as? String {
         //   secondStep.applyCourseTypeId = Int(apply_course_type_id)!
        }
        
        if let interested_year = data["interested_year"] as? String {
           // secondStep.interestedYear = interested_year
        }
        
        if let interested_year = data["interested_category_id"] as? [String] {
            if let first = interested_year.first {
            //s   secondStep.interestedCategoryId =  Int(first)!
            }
        }
        */
       
        //***********************************************//
        // MARK: STEP THREE
        //***********************************************//
        /// GRE
        if let valid_scores = data["valid_scores"] as? String{
            thirdStep.isValidScore = valid_scores
        }
        
        /// english_exam_level
        if let interested_country = data["interested_country"] as? [String]{
            print(interested_country)
        }
        
        if let gre_exam_date = data["gre_exam_date"] as? String{
            thirdStep.greExamDate = gre_exam_date
            if  gre_exam_date == "0000-00-00" {
                 thirdStep.greExamDate = ""
            }
        }
        if let gre_verbal_score = data["gre_verbal_score"] as? String{
            thirdStep.greVerbalScore = gre_verbal_score
        }
        if let gre_verbal = data["gre_verbal"] as? String{
            thirdStep.greVerbal = gre_verbal
        }
        
        if let gre_quantitative_score = data["gre_quantitative_score"] as? String{
            thirdStep.greQuantitativeScore = gre_quantitative_score
        }
        if let gre_quantitative = data["gre_quantitative"] as? String{
            thirdStep.greQuantitative = gre_quantitative
        }
        if let gre_analytical_writing_score = data["gre_analytical_writing_score"] as? String{
            thirdStep.greAnalyticalWritingScore = gre_analytical_writing_score
        }
        if let gre_analytical_writing = data["gre_analytical_writing"] as? String{
            thirdStep.greAnalyticalWriting = gre_analytical_writing
        }
        
        //// GMAT
        if let gmat_exam_date = data["gmat_exam_date"] as? String{
             thirdStep.gMatExamDate = gmat_exam_date
            if  gmat_exam_date == "0000-00-00" {
               thirdStep.gMatExamDate = ""
            }
           
        }
        if let gmat_verbal_score = data["gmat_verbal_score"] as? String{
            thirdStep.gMatVerbalScore = gmat_verbal_score
        }
        
        if let gmat_verbal = data["gmat_verbal"] as? String{
            thirdStep.gMatVerbal = gmat_verbal
        }
        if let gmat_quantitative_score = data["gmat_quantitative_score"] as? String{
            thirdStep.gMatQuantitativeScore = gmat_quantitative_score
        }
        
        if let gmat_quantitative = data["gmat_quantitative"] as? String{
            thirdStep.gMatQuantitative = gmat_quantitative
        }
        
        if let gmat_analytical_writing_score = data["gmat_analytical_writing_score"] as? String{
            thirdStep.gMatAnalyticalWritingScore = gmat_analytical_writing_score
        }
        if let gmat_analytical_writing = data["gmat_analytical_writing"] as? String{
            thirdStep.gMatAnalyticalWriting = gmat_analytical_writing
        }
        
        if let gmat_total_score = data["gmat_total_score"] as? String{
            thirdStep.gMatTotalScore = gmat_total_score
        }
        
        if let gmat_analytical_writing_score = data["gmat_analytical_writing_score"] as? String{
            thirdStep.gMatAnalyticalWritingScore = gmat_analytical_writing_score
        }
        if let gmat_total_percentage = data["gmat_total_percentage"] as? String{
            thirdStep.gMatTotalScorePer = gmat_total_percentage
        }
        
        /// Sat
        
        if let sAtExamDare   = data["sat_exam_date"] as? String{
             thirdStep.sAtExamDare = sAtExamDare
            if  sAtExamDare == "0000-00-00" {
              thirdStep.sAtExamDare = ""
            }
           
        }
        if let sat_raw_score = data["sat_raw_score"] as? String{
            thirdStep.sAtRawScore = sat_raw_score
        }
        if let sat_math_score = data["sat_math_score"] as? String{
            thirdStep.sAtMathScore = sat_math_score
        }
        if let sat_reading_score = data["sat_reading_score"] as? String{
            thirdStep.sAtReadingScore = sat_reading_score
        }
        
        if let sat_writing_language_score = data["sat_writing_language_score"] as? String{
            thirdStep.sAtWritingLanguageScore = sat_writing_language_score
        }
        
        if let sat_exam_date = data["sat_exam_date"] as? String{
            thirdStep.sAtWritingLanguageScore = sat_exam_date
        }
        
        if let sat_writing_score = data["sat_writing_score"] as? String{
            thirdStep.sAtWritingLanguageScore = sat_writing_score
        }
        
        if let english_exam_level = data["english_exam_level"] as? [String:Any] {
           thirdStep.englishExamLevel = english_exam_level
        }
        
        if let qualified_exams = data["qualified_exams"] as? [[String:String]] {
            thirdStep.qualifiedExams = qualified_exams
        }
        /// step four
        /*
        if let language_proficiency_id = data["language_proficiency_id"] as? String{
            fourthStep.languageProficiencyId = Int(language_proficiency_id)!
        }
        
        if let source_of_information_id = data["source_of_information_id"] as? String{
            fourthStep.sourceOfInformationId = Int(source_of_information_id)!
        }
        
        if let budget_id = data["budget_id"] as? String{
            fourthStep.budgetId = Int(budget_id)!
        }
        
        if let cvName = data["cv_name"] as? String {
            fourthStep.cvName = cvName
            
        }
        
        if let cvPath = data["cv_path"] as? String {
            fourthStep.cvUrl = cvPath
        }
        if let experienceDetails = data["work_experience_detail"] as? String {
            fourthStep.experienceDetail      = experienceDetails
        }
        if let experienceStatus = data["work_experience_status"] as? String {
            fourthStep.experienceStatus      = experienceStatus
        }
       */
        
        
        if let eudcationDetailsArray = data["completed_educations"] as? [[String:Any]],eudcationDetailsArray.isEmpty == false {
                   eudcationDetailsArray.forEach { (eduDict) in
                       if let eduName = eduDict["degree_name"] as? String {
                           switch eduName {
                           case "high_school":highSchoolDetails = HighSchoolModel(with:eduDict)
                           highSchoolDetails.name               = "high_school"
                           case "bachelors":graduationDetails   = GraduationModel(with:eduDict)
                           graduationDetails.name               = "bachelors"
                           case "masters":postGraduationDetails = PostGraduationModel(with: eduDict)
                           postGraduationDetails.name           = "masters"
                           case "other":otherEducationDetails   = OtherEudcationModel(with: eduDict)
                           otherEducationDetails.name           = "other"
                           default:break
                           }
                       }
                   }
               }
        
    }
}
