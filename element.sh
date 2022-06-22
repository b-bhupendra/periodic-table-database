#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


DISTINCT(){

MAIN_QUERY="select * from properties inner join elements on properties.atomic_number=elements.atomic_number full join types on properties.type_id=types.type_id"
 

if [[ $1 =~ ^[0-9]+$ ]]
then

  QUR=$($PSQL "$MAIN_QUERY WHERE elements.atomic_number=$1")
  #echo $QUR
  PRINT_INFO $QUR
  
elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
then

  QUR=$($PSQL "$MAIN_QUERY WHERE elements.symbol='$1'")
  #echo $QUR
  PRINT_INFO $QUR

else

  QUR=$($PSQL "$MAIN_QUERY WHERE elements.name='$1'")
  #echo $QUR
  PRINT_INFO $QUR

fi

}

PRINT_INFO(){
  
  if [[ $1 ]]
  then
  IFS="|"; read ATOMIC_NUM ATOMIC_MASS MEL_POINT BOILING_POINT TYPE_ID ATOMIC_NUM SYMBOL ELE_NAME TYPE_ID TYPE <<< $1
  
  INFORMATION $ATOMIC_NUM $ELE_NAME $SYMBOL $TYPE $ATOMIC_MASS $MEL_POINT $BOILING_POINT
  else
    echo  "I could not find that element in the database."
  fi
}

INFORMATION(){
  # 1 atomic number
  # 2 element name
  # 3 atomic symbol
  # 4 type 
  # 5 atomic_mass
  # 6 melting point
  # 7 boiling point
  # The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  echo  "The element with atomic number $1 is $2 ($3). It's a $4, with a mass of $5 amu. $2 has a melting point of $6 celsius and a boiling point of $7 celsius."
}



if [[ $1 ]]
then
  DISTINCT $1
else
  echo -e "Please provide an element as an argument."
fi


