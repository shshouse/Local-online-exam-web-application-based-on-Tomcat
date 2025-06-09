CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    student_id VARCHAR(50) NOT NULL UNIQUE,
    course VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS teachers (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    teacher_id VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    teacher_id VARCHAR(50) NOT NULL,              -- 出题教师
    title VARCHAR(255) NOT NULL,                  -- 题目标题/内容
    type INT NOT NULL,                            -- 题目类型 (1: 单选, 2: 多选, 3: 填空)
    options TEXT,                                 -- 题目选项 (JSON 格式存储)
    answer TEXT NOT NULL,                         -- 正确答案
    explanation TEXT,                             -- 答案解析
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS student_answers (
    id SERIAL PRIMARY KEY,
    question_id INT NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,                        -- 学生的答案
    is_correct BOOLEAN DEFAULT FALSE,             -- 是否正确
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
