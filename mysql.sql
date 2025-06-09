CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    student_id VARCHAR(50) NOT NULL UNIQUE,
    course VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    teacher_id VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS questions(
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id VARCHAR(50) NOT NULL,              -- 出题教师
    title VARCHAR(255) NOT NULL,                  -- 题目标题/内容
    type INT NOT NULL,                            -- 类型：1=单选，2=多选，3=填空，4=大题
    options TEXT,                                 -- 选项（JSON 格式或逗号分隔），可为空（非单/多选题时）
    answer TEXT NOT NULL,                         -- 正确答案（格式根据题型不同而变化）
    score DECIMAL(5, 2) DEFAULT 0.00,             -- 每道题的分数
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE IF NOT EXISTS student_answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,                        -- 学生的答案
    is_correct BOOLEAN DEFAULT NULL,              -- 是否正确（可用于自动判题）
    score_achieved DECIMAL(5, 2) DEFAULT 0.00,   -- 获得的分数
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (question_id) REFERENCES questions(id),   -- 外键约束
    FOREIGN KEY (student_id) REFERENCES students(student_id)--  外键约束
);
