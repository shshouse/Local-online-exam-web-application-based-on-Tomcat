package com.example.blog.util;

import com.example.blog.model.Question;
import com.example.blog.model.Teacher;

public class PermissionUtils {
//这个类用于教师，是写来验证是不是当前用户是该问题的作者
    public static boolean isOwner(Question question, Teacher currentTeacher) {
        return question != null && currentTeacher != null &&
                question.getTeacherId() != null &&
                question.getTeacherId().equals(currentTeacher.getTeacherId());
    }
}