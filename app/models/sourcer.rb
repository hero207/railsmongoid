class Sourcer
  include ActiveModel::Model

  attr_accessor :filter 

  # :sort_by
  # :sort_order
  # :asked_by
  # :requested_by 
  # :type   --- If type is answer, then return only those questions, which have at least one "active=true" answer doc
  #    --- If type is question, then return all questions, which have no "active=true" answer doc or no answer doc at all
  # :answerd_by
  # :commented_by
  # :liked_by
  # :asked_to
  # :user_status 
  # :question_active 
  # :comment_active 
  # :answer_active 
  # :page_start_from
  # :page_offset
  
  def initialize (f = {})
    @filter = f
    setDefault
  end

  def getData
    # TODO: Write your code to return data in hash, as sample shown below


    # [
    #   {
    #     "qid": "55ea003e4102135d9d000002",
    #     "has_any_answer": true,
    #     "text": "What is your name?",
    #     "asked_by_user": {
    #       "name": "Jennifer lookui",
    #       "username": "jcool",
    #       "avatar_image": "https://media.mongodb.org/logo-her8oer-header.png"
    #     },
    #     "is_answerer": true, # loggedin_user_id is one of the "asked_to"?
    #     "is_asker": false, # loggedin_user_id == asked_by_user ?
    #     "requested_answer": true, # loggedin_user_id is one of the "requestors"?
    #     "requestor_count": 4, 
    #     "asked_to": [
    #       {
    #         "id": "55e7668c4102132ea8000065", # 
    #         "name": "Sophia tokan",
    #         "username": "stokan",
    #         "avatar_image": "https://media.mongodb.org/logo-mongodb-header.png",
    #         "answer": {
    #           "id": "q424wter45345ersuhwiuwfdsfg",
    #           "text": "My name is sophia",
    #           "like_count": 21,
    #           "comment_count": 0,
    #           "has_liked": true, # loggedin_user_id liked this answer?
    #           "has_commented": false # loggedin_user_id commented on this answer?
    #         }
    #       },
    #       {
    #         "id": "kgfuwe7iryukwhjerl", # 
    #         "name": "Laura Nanop",
    #         "username": "lnop",
    #         "avatar_image": "https://media.mongodb.org/ldfsdfr.png",
    #         "answer": {
    #           "id": "7ir8o24uiw9eup0owe",
    #           "text": "My name is Laura",
    #           "like_count": 1,
    #           "comment_count": 0,
    #           "has_liked": false, # loggedin_user_id liked this answer?
    #           "has_commented": false # loggedin_user_id commented on this answer?
    #         }
    #       }
    #     ]
    #   },
    #   {
    #     "qid": "97845398uioruw7589304",
    #     "has_any_answer": false,
    #     "text": "What is your age?",
    #     "asked_by_user": {
    #       "name": "Sam Mol",
    #       "username": "smolss",
    #       "avatar_image": "https://media.mongodb.org/lrewwerwer-header.png"
    #     },
    #     "is_answerer": false, # loggedin_user_id is one of the "asked_to"?
    #     "is_asker": false, # loggedin_user_id == asked_by_user ?
    #     "requested_answer": false, # loggedin_user_id is one of the "requestors"?
    #     "requestor_count": 4
    #   }
    # ]

  end



  private

  def setDefault
    @filter[:type]            = sanitize :type
    @filter[:sort_by]         = sanitize :sort_by
    @filter[:sort_order]      = sanitize :sort_order
    @filter[:question_active] = sanitize :question_active
    @filter[:comment_active]  = sanitize :comment_active
    @filter[:answer_active]   = sanitize :answer_active
    @filter[:user_status]     = sanitize :user_status

    @filter[:page_start_from] = @filter[:page_start_from].present?  ? @filter[:page_start_from].to_i : 1
    @filter[:page_offset]     = @filter[:page_offset].present?      ? @filter[:page_offset].to_i : 10
    @filter[:asked_to]        = @filter[:asked_to].present?         ? @filter[:asked_to] : nil
    @filter[:asked_by]        = @filter[:asked_by].present?         ? @filter[:asked_by] : nil
    @filter[:requested_by]    = @filter[:requested_by].present?     ? @filter[:requested_by] : nil
    @filter[:commented_by]    = @filter[:commented_by].present?     ? @filter[:commented_by] : nil
    @filter[:liked_by]        = @filter[:liked_by].present?         ? @filter[:liked_by] : nil

    @filter[:loggedin_user_id] = @filter[:loggedin_user_id]
  end

  def sanitize key
    case key
    when :type
      [:answer, :question].include? @filter[key] ? @filter[key] : :answer
    when :sort_by
      [:time, :popularity].include? @filter[key] ? @filter[key] : :time
    when :sort_order
      [:asc, :desc].include? @filter[key] ? @filter[key] : :desc
    when :user_status
      [:active, :inactive].include? @filter[key] ? @filter[key] : :active
    when :question_active, :comment_active, :answer_active
      [true, false].include? @filter[key] ? @filter[key] : true
    end
  end

end