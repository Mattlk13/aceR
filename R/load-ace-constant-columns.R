
#' ACE column name constants
#'
#' @keywords internal
#' @name ace_header
NULL

#' @name ace_header
COL_FILE = "file"

#' @name ace_header
Q_COL_FILE = rlang::sym(COL_FILE)

#' @name ace_header
COL_TIME = "time"

#' @name ace_header
Q_COL_TIME = rlang::sym(COL_TIME)

#' @name ace_header
COL_N_FINISHED = "times_finished_game"

#' @name ace_header
Q_COL_N_FINISHED = rlang::sym(COL_N_FINISHED)

#' @name ace_header
COL_RT = "rt"

#' @name ace_header
Q_COL_RT = rlang::sym(COL_RT)

#' @name ace_header
COL_CORRECT_BUTTON = "correct_button"

#' @name ace_header
Q_COL_CORRECT_BUTTON = rlang::sym(COL_CORRECT_BUTTON)

#' @name ace_header
COL_PREV_CORRECT_BUTTON = "previous_correct_button"

#' @name ace_header
Q_COL_PREV_CORRECT_BUTTON = rlang::sym(COL_PREV_CORRECT_BUTTON)

#' @name ace_header
COL_CORRECT_RESPONSE = "correct_response"

#' @name ace_header
Q_COL_CORRECT_RESPONSE = rlang::sym(COL_CORRECT_RESPONSE)

#' @name ace_header
COL_RW = "rw"

#' @name ace_header
Q_COL_RW = rlang::sym(COL_RW)

#' @name ace_header
COL_LATE_RESPONSE = "late_response"

#' @name ace_header
Q_COL_LATE_RESPONSE = rlang::sym(COL_LATE_RESPONSE)

#' @name ace_header
COL_PREV_LATE_RESPONSE = "previous_late_response"

#' @name ace_header
Q_COL_PREV_LATE_RESPONSE = rlang::sym(COL_PREV_LATE_RESPONSE)

#' @name ace_header
COL_CONDITION = "condition"

#' @name ace_header
Q_COL_CONDITION = rlang::sym(COL_CONDITION)

#' @name ace_header
COL_STUDY_COND = "study_condition"

#' @name ace_header
Q_COL_STUDY_COND = rlang::sym(COL_STUDY_COND)

#' @name ace_header
COL_PID = "pid"

#' @name ace_header
Q_COL_PID = rlang::sym(COL_PID)

#' @name ace_header
COL_BID = "bid"

#' @name ace_header
Q_COL_BID = rlang::sym(COL_BID)

#' @name ace_header
COL_BID_SHORT = "bid_short"

#' @name ace_header
Q_COL_BID_SHORT = rlang::sym(COL_BID_SHORT)

#' @name ace_header
COL_NAME = "name"

#' @name ace_header
Q_COL_NAME = rlang::sym(COL_NAME)

#' @name ace_header
COL_AGE = "age"

#' @name ace_header
Q_COL_AGE = rlang::sym(COL_AGE)

#' @name ace_header
COL_GRADE = "grade"

#' @name ace_header
Q_COL_GRADE = rlang::sym(COL_GRADE)

#' @name ace_header
COL_GENDER = "gender"

#' @name ace_header
Q_COL_GENDER = rlang::sym(COL_GENDER)

#' @name ace_header
COL_HANDEDNESS = "handedness"

#' @name ace_header
Q_COL_HANDEDNESS = rlang::sym(COL_HANDEDNESS)

#' @name ace_header
COL_SUB_ID = "subid"

#' @name ace_header
Q_COL_SUB_ID = rlang::sym(COL_SUB_ID)

#' @name ace_header
COL_PRACTICE = "session_type"

#' @name ace_header
Q_COL_PRACTICE = rlang::sym(COL_PRACTICE)

#' @name ace_header
COL_TRIAL_TYPE = "trial_type"

#' @name ace_header
Q_COL_TRIAL_TYPE = rlang::sym(COL_TRIAL_TYPE)

#' @name ace_header
COL_BLOCK_HALF = "half"

#' @name ace_header
Q_COL_BLOCK_HALF = rlang::sym(COL_BLOCK_HALF)

#' @name ace_header
ALL_POSSIBLE_DEMOS <- c(COL_BID, COL_PID, COL_AGE, COL_GRADE, COL_GENDER, COL_HANDEDNESS, COL_TIME, COL_FILE)

#' @name ace_header
Q_ALL_POSSIBLE_DEMOS <- c(Q_COL_BID, Q_COL_PID, Q_COL_AGE, Q_COL_GRADE, Q_COL_GENDER, Q_COL_HANDEDNESS, Q_COL_TIME, Q_COL_FILE)

#' @name ace_header
ALL_POSSIBLE_EXPLORE_DEMOS = c("updated_at", "o_s_version", "app_id", "build", "client_time_zone",
                               "client_time_zone_offset", "device_model", "device_name",
                               "device_type", "games_map_dialog_stage", "games_play_count",
                               "games_scores", "graphics_device_name", "handedness",
                               "i18n", "install_mode", "processor_count",
                               "processor_frequency", "runtime_platform", "section",
                               "system_memory_size", "times_finished_game", "games_played")

#' @name ace_header
Q_ALL_POSSIBLE_EXPLORE_DEMOS = rlang::syms(ALL_POSSIBLE_EXPLORE_DEMOS)

#' @importFrom dplyr case_when
#' @name ace_header

standardize_ace_column_names <- function(df) {
  new = names(df)
  new = case_when(new == "response_time" ~ COL_RT,
                  new == "response_window" ~ COL_RW,
                  new %in% c("participant_id", "user_id") ~ COL_PID,
                  new == "user_name" ~ COL_NAME,
                  new == "user_age" ~ COL_AGE,
                  new == "user_grade" ~ COL_GRADE,
                  new %in% c("user_gender", "age1", "user_age1") ~ COL_GENDER,
                  new == "user_handedness" ~ COL_HANDEDNESS,
                  # created_at seems to be ACE Explore specific. beware versioning issues
                  new %in% c("time_gameplayed_utc", "created_at") ~ COL_TIME,
                  new == "time_sent_utc" ~ "timesent_utc",
                  new == "id" ~ COL_SUB_ID,
                  new == "details" ~ COL_CONDITION,
                  new == "task_switch_state" ~ "taskswitch_state",
                  TRUE ~ new) # for cross compatibility b/w emailed and pulvinar)
  names(df) = new
  return (df)
}

#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom rlang !! :=
#' @keywords internal

standardize_ace_ids <- function(dat) {
  
  if (!(COL_PID %in% names(dat))) {
    col_to_bid_id = Q_COL_FILE
    dat <- dat %>%
      mutate(!!COL_PID := guess_pid(!!Q_COL_FILE))
  } else {
    col_to_bid_id = Q_COL_PID
  }
  
  if (COL_N_FINISHED %in% names(dat)) {
    col_to_bid_session = Q_COL_N_FINISHED
    bid_sep = ".session"
  } else {
    col_to_bid_session = Q_COL_TIME
    bid_sep = "."
  }
  
  # very band-aid: attempt to repair PID using name field if PID is empty stem or otherwise filler
  if (all(unique(dat[[COL_PID]]) %in% c("ADMIN-UCSF-", "ADMIN-UCSF-0", "ADMIN-UCSF-0000")) & COL_NAME %in% names(dat)) {
    dat <- dat %>%
      mutate(!!COL_PID := paste0("ADMIN-UCSF-", !!Q_COL_NAME))
  }
  
  dat <- dat %>%
    # To comply with ACE Explorer
    mutate(!!COL_PID := stringr::str_replace_all(tolower(!!Q_COL_PID), "[^a-zA-Z0-9]+", ""),
           # make block id from pid & time
           !!COL_BID := paste(!!col_to_bid_id, !!col_to_bid_session, sep = bid_sep))
  
}

#' @keywords internal

guess_pid <- function(x) {
  file = basename(x)
  # maybe_pid = stringr::str_extract(file, "^[a-zA-Z0-9]*")
  maybe_pid = unique(na.omit(as.numeric(unlist(strsplit(unlist(file), "[^0-9]+")))))[1]
  return (maybe_pid)
}

#' @name ace_header
#' @import dplyr
#' @importFrom lubridate parse_date_time
#' @importFrom magrittr %>%
#' @importFrom rlang !! :=
#' @importFrom stringr str_replace

standardize_ace_column_types <- function (df) {
  # re-type non-character columns to their intended types
  # All of these should behave the same on classroom and explorer data
  
  try({
    df <- df %>%
      mutate(# !!COL_TIME := str_replace(!!Q_COL_TIME, "T", ""), # the T causes parse_date_time to flip out
        # parse_date_time appears to be behaving okay with the T in between the date and time... as of apr 27 2019
        time1 = suppressWarnings(parse_date_time(!!Q_COL_TIME, "ymdHMSz")),
        time2 = suppressWarnings(parse_date_time(!!Q_COL_TIME, "abdyHMSz")),
        !!COL_TIME := coalesce(time1, time2)) %>%
      select(-time1, -time2)
  }, silent = TRUE)
  
  # No responses in classroom (pulvinar) are coded as "N/A"
  # No responses in explorer are coded as 0
  # Neither of these should fail on the other case
  try({
    df <- df %>%
      mutate(!!COL_RT := as.numeric(!!Q_COL_RT),
             !!COL_RT := na_if(!!Q_COL_RT, 0))
  }, silent = TRUE)
  
  try({
    df <- df %>%
    mutate_at(COL_RW, as.numeric)
  }, silent = TRUE)
  
  # code correct_button with words, not 0 and 1
  # No responses in classroom (pulvinar) are coded as "N/A" in the RT column
  # No responses in explorer are coded as 0 in the RT column
  # Neither of these should fail on the other case
  try({
    df <- df %>%
      mutate(!!COL_CORRECT_BUTTON := dplyr::recode(!!Q_COL_CORRECT_BUTTON, `0` = "incorrect", `1` = "correct"),
             # Noticed this in ACE Explorer as of Jan 2020. Might have changed before then
             !!COL_CORRECT_BUTTON := if_else(is.na(!!Q_COL_RT),
                                             "no_response",
                                             !!Q_COL_CORRECT_BUTTON))
  }, silent = TRUE)
  
  # various condition cols that should be numeric
  try(suppressWarnings({
    df <- df %>%
    mutate_at(vars(one_of(c("position_is_top",
                            "is_valid_cue",
                            "object_count"))), as.numeric)
  }), silent = TRUE)
  
  try({
    df <- df %>%
      mutate_at(COL_AGE, as.numeric)
  }, silent = TRUE)
  
  try({
    df <- df %>%
      mutate_at(COL_CONDITION, tolower)
  }, silent = TRUE)
  
  
  try({
    df <- df %>%
      mutate_at(COL_TRIAL_TYPE, tolower)
  }, silent = TRUE)
  
  return (df)
}

#' @name ace_header
#' @importFrom dplyr coalesce funs group_by if_else lag mutate mutate_at one_of recode ungroup
#' @importFrom lubridate parse_date_time
#' @importFrom magrittr %>%
#' @importFrom rlang sym !! :=
#' @importFrom stringr str_replace

standardize_ace_values <- function(df, app_type) {
  # this function handles re-typing of columns
  # especially in emailed data, all columns are necessarily read in as character
  # we SHOULD hard-code expected type of columns by module
  
  cols = names(df)
  
  if (app_type %in% c("email", "pulvinar")) {
    # Extra shit for classroom type data bc the RT no response coding was often effed up
    try({
      df <- df %>%
        mutate(!!COL_RT := na_if_true(!!Q_COL_RT, !!Q_COL_RT == !!Q_COL_RW),
               !!COL_RT := na_if_true(!!Q_COL_RT, !!Q_COL_RT %% 10 == 0))
    }, silent = TRUE)
  }
  
  # Should fail silently on classroom data with no practice trials and no practice column
  try({
    # TODO: Keep practice trials to extract data from them. Currently discarding all
    df <- df %>%
      filter(!!Q_COL_PRACTICE == "Real") %>%
      # Noticed this in ACE Explorer as of Jan 2020. Might have changed before then
      mutate(!!COL_CORRECT_BUTTON := if_else(!!Q_COL_RT == 0, "no_response", !!Q_COL_CORRECT_BUTTON))
  }, silent = TRUE)
  
  if (COL_LATE_RESPONSE %in% cols) {
    # original form of this column is 0/1
    df <- df %>%
      mutate(!!COL_LATE_RESPONSE := case_when(!!Q_COL_RT > !!Q_COL_RW ~ "late",
                                              !!Q_COL_RT < !!Q_COL_RW ~ "early",
                                              is.na(!!Q_COL_RT) ~ "no_response",
                                              TRUE ~ "late"))
    
    df <- df %>%
      group_by(!!Q_COL_BID) %>%
      mutate(!!COL_PREV_LATE_RESPONSE := make_lagged_col(!!Q_COL_LATE_RESPONSE)) %>%
      ungroup()
  }
  
  if (DEMOS %in% df$module) {
    # Only triggers for Explorer data
    # TODO: If you want ALL_POSSIBLE_EXPLORE_DEMOS, it goes in here with ALL_POSSIBLE_DEMOS
    # But maybe this functionality should wait until the device stuff is faithfully only in the task data
    df <- df %>%
      select(one_of(c(COL_MODULE, ALL_POSSIBLE_DEMOS, COL_TIME))) %>%
      mutate_at(COL_GENDER, as.character)
  }
  
  # Forcible recoding of accuracy and other things for various modules below
  # Most of this is an attempt to reconstruct accuracy as orthogonal to response lateness
  
  if (SAAT %in% df$module) {
    if (app_type %in% c("email", "pulvinar")) {
      # This fixes a condition naming error in the raw log files
      # present in classroom but fixed in explorer data
      df[[COL_CONDITION]] = plyr::mapvalues(toupper(df[[COL_CONDITION]]),
                                            from = c("IMPULSIVE", "SUSTAINED"),
                                            to = c("sustained", "impulsive"),
                                            warn_missing = FALSE)
    }
    
    df <- df %>%
      standardize_saat_tnt(col = "position_is_top")
    
  } else if (STROOP %in% df$module) {
    # This one technically varies it on classroom vs explorer,
    # but I think color_ink_shown/color_word_shown are a mid-explorer update
    # so don't assume this varies on app_type
    stroop_correct_col = sym(ifelse("color_ink_shown" %in% cols, "color_ink_shown", "color_shown"))
    df <- df %>%
      mutate(!!COL_CORRECT_BUTTON := case_when(!!Q_COL_CORRECT_BUTTON == "no_response" ~ "no_response",
                                               color_pressed == !!stroop_correct_col ~ "correct",
                                               color_pressed != !!stroop_correct_col ~ "incorrect",
                                               TRUE ~ NA_character_)) # missing implies fucked up somehow
    
  } else if (FLANKER %in% df$module) {
    df <- df %>%
      mutate(!!COL_CORRECT_BUTTON := case_when(displayed_cue %in% c("A", "B") & first_button == "YES" ~ "correct",
                                               displayed_cue %in% c("C", "D") & second_button == "YES" ~ "correct",
                                               first_button == "NO" & second_button == "NO" ~ "no_response",
                                               TRUE ~ "incorrect"))
  } else if (BRT %in% df$module) {
    # retype and clean accuracy
    df <- df %>%
      mutate(inter_time_interval = as.numeric(inter_time_interval),
             !!COL_CORRECT_BUTTON := if_else(!!Q_COL_RT != inter_time_interval,
                                             "correct",
                                             !!Q_COL_CORRECT_BUTTON,
                                             missing = !!Q_COL_CORRECT_BUTTON))
  } else if (TNT %in% df$module) {
    
    df <- df %>%
      standardize_saat_tnt(col = "is_valid_cue")
    
  } else if (FILTER %in% df$module) {
    
    # special column re-typing for filter only
    
    df <- df %>%
      mutate(original_orientation = as.numeric(original_orientation),
             degree_of_change = as.numeric(degree_of_change),
             cue_rotated = as.integer(cue_rotated))
    
    # in the past (before 2019?), degree_of_change was the meaningful variable of adaptation
    # hence this re-patching is sometimes necessary
    # I believe only applies to classroom data but may apply to old explorer data
    # So not varying on app_type just in case
    if (any(!is.na(df$degree_of_change))) {
      df <- df %>%
        mutate(# 180 degree rotation was incorrectly marked as "change" when there's no visual change
               cue_rotated = if_else(abs(round(degree_of_change, 2)) == 3.14,
                                     0L,
                                     cue_rotated),
               !!COL_CORRECT_BUTTON := case_when(abs(round(degree_of_change, 2)) == 3.14 & correct_button == "correct" ~ "incorrect",
                                                 abs(round(degree_of_change, 2)) == 3.14 & correct_button == "incorrect" ~ "correct",
                                                 TRUE ~ !!Q_COL_CORRECT_BUTTON))
    }
    
    #Add in trial_accuracy labels for Filter. For cue is rotated, if RT >cutoff and not equal to response window, and correct_button is correct, hit, else miss
    #For cue is not rotated, if RT >cutoff and not equal to response window, and correct_button is correct, then correct rejection, else false alarm
    #This will also ensure RTs < cutoff are incorrect regardless of condition/button press
    df <- df %>%
      mutate(trial_accuracy = case_when(cue_rotated & !!Q_COL_CORRECT_BUTTON == "correct" ~ "Hit",
                                        cue_rotated & !!Q_COL_CORRECT_BUTTON == "incorrect" ~ "Miss",
                                        !cue_rotated & !!Q_COL_CORRECT_BUTTON == "correct" ~ "Correct Rejection",
                                        !cue_rotated & !!Q_COL_CORRECT_BUTTON == "incorrect" ~ "False Alarm",
                                        is.na(rt) ~ "no_response",
                                        TRUE ~ NA_character_))
    
  }
  
  # needs to be called LAST, after all the other boutique accuracy corrections are complete
  if (COL_CORRECT_BUTTON %in% cols) {
    df <- df %>%
      # needs to be grouped to prevent previous_correct_button from bleeding over between records
      group_by(!!Q_COL_BID) %>%
      mutate(!!COL_PREV_CORRECT_BUTTON := make_lagged_col(!!Q_COL_CORRECT_BUTTON)) %>%
      ungroup()
  }
  
  return (df)
}

#' @importFrom dplyr mutate case_when
#' @importFrom magrittr %>%
#' @importFrom rlang sym !! :=
#' @keywords internal

standardize_saat_tnt <- function(df, col) {
  # Correct hits and misses. For position is on top, if RT, hit, else miss
  # For position in not on top, if no RT, then correct rejection, else false alarm
  # short rt no longer considered as a factor
  # Also recode no-go RTs (eg position not on top) and miss RTs (correct button = 0) as -99 for special treatment

  q_col = sym(col)
  df <- df %>%
    mutate(trial_accuracy = case_when(!!q_col == 1 & (!is.na(!!Q_COL_RT) & !!Q_COL_RT != 0) ~ "Hit",
                                      !!q_col == 1 & (is.na(!!Q_COL_RT) | !!Q_COL_RT == 0) ~ "Miss",
                                      !!q_col == 0 & (is.na(!!Q_COL_RT) | !!Q_COL_RT == 0) ~ "Correct Rejection",
                                      !!q_col == 0 & (!is.na(!!Q_COL_RT) & !!Q_COL_RT != 0) ~ "False Alarm",
                                      TRUE ~ NA_character_),
           !!COL_CORRECT_BUTTON := case_when(trial_accuracy %in% c("Hit", "Correct Rejection") ~ "correct",
                                             trial_accuracy %in% c("Miss", "False Alarm") ~ "incorrect",
                                             TRUE ~ NA_character_),
           !!COL_RT := if_else(!!q_col == 0 | (!!q_col == 1 & !!Q_COL_CORRECT_BUTTON == "incorrect"), -99, !!Q_COL_RT))

  
  return (df)
}
