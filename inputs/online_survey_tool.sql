CREATE TABLE online_survey_tool_schema.surveys (
    SURVEY_ID SERIAL PRIMARY KEY,
    SURVEY_NAME VARCHAR(255),
    SURVEY_ST_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SURVEY_END_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP + INTERVAL '5 days',
    SURVEY_STATE VARCHAR(50) DEFAULT 'Active'
);

INSERT INTO online_survey_tool_schema.surveys (SURVEY_NAME, SURVEY_ST_DATE, SURVEY_END_DATE, SURVEY_STATE)
VALUES
('RAG_SURVEY_CA', '2025-05-22 10:00:00', '2025-05-22 18:00:00', 'Active'),
('TEST_SURVEY', '2025-05-20 10:00:00', '2025-05-22 18:00:00', 'Active'),
('RAG_SURVEY_IND', '2025-06-12 10:00:00', '2025-06-22 18:00:00', 'Active');

CREATE TABLE online_survey_tool_schema.qtypes (
    QTYPE_ID SERIAL PRIMARY KEY,
    QTYPE VARCHAR(50) UNIQUE,
    QTYPE_NOTES VARCHAR(255)
);

INSERT INTO online_survey_tool_schema.qtypes (QTYPE, QTYPE_NOTES)
VALUES
('multi-choice', 'Multiple choice question'),
('true_false', 'True or False'),
('multi-select', 'Multiple sections'),
('text_input', 'Input Text field'),
('three_options', '3 Options');

CREATE TABLE online_survey_tool_schema.ChoiceBank (
    ChoiceBank_id  SERIAL PRIMARY KEY,
    multi_choice_id INT,
    multi_choice_option_id INT,
    multi_choice_type VARCHAR(50),
    multi_choice_txt VARCHAR(255)
);

-- Inserting the data (as before)
INSERT INTO online_survey_tool_schema.ChoiceBank (multi_choice_id, multi_choice_option_id, multi_choice_type, multi_choice_txt)
VALUES
(1, 1, 'SURVEY', 'Extremely Agree'),
(1, 2, 'SURVEY', 'Somewhat Agree'),
(1, 3, 'SURVEY', 'Agree'),
(1, 4, 'SURVEY', 'Somewhat Disagree'),
(1, 5, 'SURVEY', 'Extremely Disagree'),
(2, 1, 'EXPERTISE', 'Expert Level'),
(2, 2, 'EXPERTISE', 'Advanced Level'),
(2, 3, 'EXPERTISE', 'Contribution Level'),
(2, 4, 'EXPERTISE', 'Lerner Level'),
(2, 5, 'EXPERTISE', 'Novice Level'),
(3, 1, 'BINARY', 'Yes/True'),
(3, 2, 'BINARY', 'No/False'),
(4, 1, 'TERNARY', 'Yes/True'),
(4, 2, 'TERNARY', 'Some what'),
(4, 3, 'TERNARY', 'No/False');

-- You can verify the data in the new table with this query:
SELECT * FROM online_survey_tool_schema.ChoiceBank;

-- Create the QBANK table
CREATE TABLE online_survey_tool_schema.QBANK (
    QUESTION_ID SERIAL PRIMARY KEY,
    SURVEY_ID INT,
    QUESTION_TEXT TEXT,
    QTYPE_ID INT,
    multi_choice_type VARCHAR(50),
    OPTION_COUNT INT
);

ALTER TABLE online_survey_tool_schema.QBANK ADD CONSTRAINT fk_survey FOREIGN KEY (SURVEY_ID) REFERENCES online_survey_tool_schema.SURVEYS(SURVEY_ID);
ALTER TABLE online_survey_tool_schema.QBANK ADD CONSTRAINT fk_qtype FOREIGN KEY (QTYPE_ID) REFERENCES online_survey_tool_schema.QTYPES(QTYPE_ID);


-- Insert data into the QBANK table
INSERT INTO online_survey_tool_schema.QBANK (SURVEY_ID, QUESTION_TEXT, QTYPE_ID, multi_choice_type, OPTION_COUNT)
VALUES
(2, 'How much do you enjoy this topic?', 1, 'SURVEY', 5),
(2, 'How much experience you have in LLMs?', 1, 'EXPERTISE', 5),
(2, 'How much experience you have in AI Agents?', 1, 'EXPERTISE', 5),
(2, 'How much experience you have in Agentic AI?', 1, 'EXPERTISE', 5),
(2, 'How much experience you have in RAG?', 1, 'EXPERTISE', 5),
(2, 'How much experience you have in RAG Evaluation ?', 1, 'EXPERTISE', 5),
(2, 'Do you think this topic is need of the Hour?', 1, 'SURVEY', 5),
(2, 'Would you like me to share Git Repo for you to Play?', 2, 'BINARY', 2),
(2, 'Do you have Open AI API Key with you?', 2, 'BINARY', 2),
(2, 'Do you have expertitse in Python development?', 5, 'TERNARY', 3);
